//
//  MatchView.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 09/06/23.
//

import SwiftUI
import RealmSwift

struct Matchview: View {
    
    @EnvironmentObject var matchvariables: MatchVariables
    @ObservedRealmObject var innings : Innings
//    @StateObject var innings1 = Innings()
//    @StateObject var innings2 = Innings()
    
    // Outcomes
    let outcomeNumbers:[String] = ["0","1","2","3","4","5","6"];
    let outcomeOthers:[String] = ["No Ball", "Wide", "Wicket"];
    
    //Flags
    @State private var isBallNotCounted:Bool = false;
    @State private var showingPreviousOver = false;
    @State private var alertInningsCompleted = false;
    @State private var alertMatchCompleted = false;
    
    @State private var isBouncing = false
    
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Image("Grass")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader{ geometry in
                    VStack(alignment: .center){
                        
                        Text(matchvariables.chaseStarted ? "2nd Innings":"1st Innings")
                            .font(Font.title)
                            .padding()
                            .background(.thinMaterial)
                            .foregroundColor(Color.black)
                            .clipShape(Rectangle())
                            .cornerRadius(20)
                            .padding(1)
                        
                        
                        VStack(alignment: .center,spacing: 5){
                            
                            HStack(spacing:20){
                                
                                ScoreBar(leftComp: "Overs", rightComp: innings.getOversInString(totalOvers: String(matchvariables.numberOfOvers)) )
                                
                                ScoreBar(leftComp: "Wickets", rightComp: String(innings.wickets))
                                
                            }
                            
                            HStack(spacing:20){
                                
                                ScoreBar(leftComp: "Runs", rightComp: String(innings.runs))
                                
                                if(matchvariables.chaseStarted){
                                    ScoreBar(leftComp: "Target", rightComp: String(matchvariables.target))
                                }
                            }
                            
                        }.padding(1)
                        
                        
                        VStack(alignment: .center){
                            
                            // Outcome Section Begins
                            
                            HStack {
                                ForEach(outcomeNumbers, id: \.self){num in
                                    
                                    OutcomeButton(text: "\(num)") {
                                        if(!(matchvariables.inningsCompleted && !matchvariables.chaseStarted)){
                                            if( !matchvariables.chaseCompleted ){
                                                
                                                addOutcome(outcome: num , ballcounted: !isBallNotCounted)
                                                
                                                
                                                isBallNotCounted = false
                                                
                                                if(matchvariables.chaseStarted){
                                                    if(innings.runs >= matchvariables.target || (innings.ballCounter == matchvariables.numberOfOvers*6)){
                                                        
                                                        matchvariables.chaseCompleted.toggle()
                                                        matchvariables.saveMatchVariables()
                                                        alertMatchCompleted.toggle()
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            HStack {
                                ForEach(outcomeOthers, id: \.self){num in
                                    
                                    OutcomeButton(text: "\(num)" ) {
                                        
                                        if(!(matchvariables.inningsCompleted && !matchvariables.chaseStarted)){
                                            if( !matchvariables.chaseCompleted){
                                                
                                                switch(num){
                                                    
                                                case "No Ball":
                                                    addOutcome(outcome:"NB", ballcounted:false)
                                                    
                                                case "Wide":
                                                    addOutcome(outcome: "Wd", ballcounted:false)
                                                default:
                                                    addOutcome(outcome: "W", ballcounted:!isBallNotCounted)
                                                }
                                                
                                                isBallNotCounted = false
                                                
                                                if(matchvariables.chaseStarted){
                                                    if(innings.runs >= matchvariables.target || (innings.ballCounter == matchvariables.numberOfOvers*6) ){
                                                        
                                                        matchvariables.chaseCompleted.toggle()
                                                        matchvariables.saveMatchVariables()
                                                        alertMatchCompleted.toggle()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            HStack{
                                Toggle("Grant Without Ball", isOn: $isBallNotCounted)
                                    .toggleStyle(.button)
                                    .font(Font.title2)
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .background(.thinMaterial)
                                    .border(Color.black, width: 0.1)
                                    .cornerRadius(15)
                                
                                OutcomeButton(text: "UNDO") {
                                    undoOutcome()
                                    
                                    // Case 1st innings over
                                    if(matchvariables.inningsCompleted && !matchvariables.chaseStarted){
                                        matchvariables.inningsCompleted.toggle()
                                        matchvariables.saveMatchVariables()
                                    }
                                    
                                    // Case match over
                                    if(matchvariables.chaseCompleted){
                                        matchvariables.chaseCompleted.toggle()
                                        matchvariables.saveMatchVariables()
                                    }
                                    
                                }
                            }
                        }.simultaneousGesture(TapGesture().onEnded {
                            if((!matchvariables.inningsCompleted)&&(!matchvariables.chaseStarted)){
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if(innings.ballCounter == matchvariables.numberOfOvers*6){
                                        alertInningsCompleted.toggle()
                                        matchvariables.inningsCompleted.toggle()
                                        matchvariables.target = innings.runs + 1
                                        matchvariables.saveMatchVariables()
                                    }
                                }
                            }
                        })
                        .padding(20)
                        .background(.ultraThinMaterial.opacity(0.5))
                        .background(Color(uiColor: UIColor(red: 0.82, green: 1.00, blue: 0.74, alpha: 1.00)).opacity(0.2))
                        .border(.black, width: 0.15)
                        .cornerRadius(50)
                        .padding(.horizontal)
                        
                        // Outcome section Ends
                        
                        Spacer()
                        
                        VStack{
                            HStack{
                                Text("This Over")
                                    .font(Font.title2)
                                    .padding(10)
                                    .background(.thinMaterial)
                                    .foregroundColor(Color.black)
                                    .border(Color("Neva"), width:0.5)
                                    .cornerRadius(10)
                                
                                Button("Previous Over"){
                                    showingPreviousOver.toggle()
                                }
                                .font(Font.title2)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                                .sheet(isPresented: $showingPreviousOver) {
                                    
                                    let (previousOverOutcome,previousOverRuns) = innings.previousOver()
                                    
                                    PreviousOver(previousOverOutcome: previousOverOutcome, previousOverRuns: previousOverRuns)
                                }
                                
                            }
                            HStack{
                                Circle()
                                    .fill(.cyan)
                                    .frame(width: 20, height: 20)
                                
                                Text("Ball Not Counted")
                                    .padding(3)
                                    .cornerRadius(20)
                            }
                            .padding(3)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                            
                            WrappedHStackView(words: innings.thisOver())
                                .padding(.bottom)
                        }
                        
                        // Innings or Match completed stages
                        
                        if(matchvariables.inningsCompleted && !matchvariables.chaseStarted){
                            VStack(alignment: .center){
                                OutcomeButton(text: "Start 2nd innings") {
                                    matchvariables.chaseStarted.toggle()
                                    matchvariables.saveMatchVariables()
                                    
                                }
                                .shimmering()
                                .background(.thinMaterial)
                                .cornerRadius(20)
                                .offset(y: -20)
                                .scaleEffect(isBouncing ? 1.2 : 1.0)
                                .animation(Animation.spring(response: 2.5, dampingFraction: 0.8, blendDuration: 0.5).repeatForever(autoreverses: false),value: isBouncing)
                                .onAppear {
                                    isBouncing = true // Start the bouncing animation when the view appears
                                }
                            }
                            
                        }
                        
                        if(matchvariables.chaseCompleted){
                            VStack(alignment: .center){
                                TextBar(textLabel: "Match Completed!")
                                    .shimmering()
                                    .background(.thinMaterial)
                                    .cornerRadius(10)
                                
                            }
                        }
                        Spacer()
                    }.frame(maxWidth: geometry.size.width * 1)
                }
            }
            //  Ininngs completed Alert
            
            .alert("1st Innings Completed!", isPresented: $alertInningsCompleted){
                Button("OK"){
                    
                }
            }message: {
                Text("Target: \(innings.runs + 1)")
            }
            
            //  Match completed Alert
            
            .alert("Match Completed", isPresented: $alertMatchCompleted){
                Button("OK"){
                    
                }
            }message: {
                if(innings.runs >= matchvariables.target){
                    Text("Target chased succesfully - Match won by Team Batting 2nd")
                }
                else if(innings.runs == matchvariables.target-1){
                    Text("Match Drawn :)")
                }
                else{
                    Text("Score defended succesfully - Match won by Team Batting 1st")
                }
            }
        }
//        .onAppear(perform: matchvariables.variableStatus)
        
    }
     
    // -------------------------------------- Functions starts ------------------------------------
    
    // 1. func addOutcome
    
    func addOutcome(outcome outcomeOfBall:String, ballcounted: Bool){
        
        
        let outcome = Outcome()
        outcome.isBallCounted = ballcounted
        outcome.outcome = outcomeOfBall
        outcome.over = innings.currentOver
        
        $innings.inningsOutcome.append(outcome)
        
        //        inningsOutcome.append(Outcome(outcome: outcomeOfBall, isBallCounted: ballcounted, over: currentOver))
        
        
        let realm = try! Realm()
        if let innings = realm.object(ofType: Innings.self, forPrimaryKey: innings.id){
            try! realm.write{
                
                switch(outcomeOfBall){
                    
                case "Wd":
                    if(matchvariables.runForWide){
                        innings.runs += 1
                    }
                case "NB":
                    if(matchvariables.runForNoBall){
                        innings.runs += 1
                    }
                case "W":
                    if(ballcounted){
                        innings.ballCounter += 1
                        innings.wickets += 1
                    }
                    else{
                        innings.wickets += 1
                    }
                default:
                    if(ballcounted){
                        innings.ballCounter += 1;
                        innings.runs = innings.runs + (Int(outcomeOfBall) ?? 0)
                    }
                    else {
                        innings.runs = innings.runs + (Int(outcomeOfBall) ?? 0)
                    }
                }
            }
        }
    }
    
    // 2. func undoOutcome
    
    func undoOutcome(){
        
        if( innings.inningsOutcome.count != 0){
            
            let  outcomeLast = innings.inningsOutcome[innings.inningsOutcome.count-1]
            //          print(outcomeLast)
            let outCome = outcomeLast.outcome
            let isBallCounted = outcomeLast.isBallCounted
            
            let realm = try! Realm()
            if let innings = realm.object(ofType: Innings.self, forPrimaryKey: innings.id){
                try! realm.write{
                    
                    
                    if(isBallCounted){
                        innings.ballCounter -= 1;
                    }
                    switch(outCome){
                        
                    case "Wd":
                        if(matchvariables.runForWide){
                            innings.runs -= 1
                        }
                    case "NB":
                        if(matchvariables.runForNoBall){
                            innings.runs -= 1
                        }
                    case "W":
                        innings.wickets -= 1
                    default:
                        innings.runs = innings.runs - Int(outCome)!
                    }
                    
                    realm.delete(innings.inningsOutcome.last!)
                    //                   inningsOutcome.removeLast()
                    
                    return
                }
            }
        }
    }
    
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        Matchview(innings: Innings())
            .environmentObject(MatchVariables())
    }
}

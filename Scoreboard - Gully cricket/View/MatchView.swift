//
//  MatchView.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 09/06/23.
//

import SwiftUI

struct Matchview: View {
    
    @EnvironmentObject var matchvariables: MatchVariables
    
    // Outcomes
    let outcomeNumbers:[String] = ["0","1","2","3","4","5","6"];
    let outcomeOthers:[String] = ["No Ball", "Wide", "Wicket"];
    
    let colors: [String: Color] = [ "NB":.teal, "Wd": .teal, "W": .red ]
    
    //Flags
    @State private var isBallNotCounted:Bool = false;
    @State private var inningsCompleted:Bool = true;
    
    // logic needed
    @State var innings = Innings()
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Image("Grass")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center){
                    
                    Text("1st Innings")
                        .font(Font.title)
                        .padding()
                        .background(.thinMaterial)
                        .foregroundColor(Color.black)
                        .clipShape(Rectangle())
                        .cornerRadius(20)
                        .padding()
                    
                    
                    VStack(alignment: .center,spacing: 15){
                        
                        HStack(spacing:20){
                            ScoreBar(leftComp: "Overs", rightComp: innings.getOversInString(totalOvers: String(matchvariables.numberOfOvers)))
                            ScoreBar(leftComp: "Wickets", rightComp: String(innings.wickets))
                        }
                        
                        HStack(spacing:20){
                            ScoreBar(leftComp: "Runs", rightComp: String(innings.runs))
                            if(matchvariables.chaseStarted){
                                ScoreBar(leftComp: "Target", rightComp: String(innings.runs + 1))
                            }
                        }
                        
                    }.padding(5)
                    
                    VStack(alignment: .center){
                        
                        HStack {
                            ForEach(outcomeNumbers, id: \.self){num in
                                OutcomeButton(text: "\(num)") {
                                    innings.addOutcome(outcome: num , ballcounted: !isBallNotCounted)
                                    isBallNotCounted = false
                                }
                            }
                        }
                        
                        HStack {
                            ForEach(outcomeOthers, id: \.self){num in
                                OutcomeButton(text: "\(num)" ) {
                                    switch(num){
                                    case "No Ball":
                                        innings.addOutcome(outcome:"NB", ballcounted:false)
                                    case "Wide":
                                        innings.addOutcome(outcome: "Wd", ballcounted:false)
                                    default:
                                        innings.addOutcome(outcome: "W", ballcounted:!isBallNotCounted)
                                        
                                    }
                                    isBallNotCounted = false
                                }
                            }
                        }
                        
                        HStack{
                            Toggle("Grant WithOut ball", isOn: $isBallNotCounted)
                                .toggleStyle(.button)
                                .font(Font.title2)
                                .padding(10)
                                .foregroundColor(.black)
                                .background(.thinMaterial)
                                .border(Color.black, width: 0.1)
                                .cornerRadius(15)
                            
                           OutcomeButton(text: "UNDO") {
                                innings.undoOutcome()
                            }
                        }
                    }.simultaneousGesture(TapGesture().onEnded {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            print(innings.ballCounter, matchvariables.numberOfOvers*6)
                            if(innings.ballCounter == matchvariables.numberOfOvers*6){
                                matchvariables.inningsCompleted.toggle()
                            }
                        }
                    })
                    .padding(25)
                    .background(.ultraThinMaterial)
                    .cornerRadius(50)
                    
                    
                    
                    Spacer()
                 
                        VStack{
                            
                            Text("This Over")
                                .font(Font.title2)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                            
                            WrappedHStackView(words: innings.thisOver())
                            
                            
                        }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
            .alert("1st Innings Completed!", isPresented: $matchvariables.inningsCompleted){
                Button("OK"){
                    matchvariables.chaseStarted.toggle()
                }
            }message: {
                Text("Target: \(innings.runs + 1)")
            }
        }
    }
    
}



struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        Matchview()
            .environmentObject(MatchVariables())
    }
}

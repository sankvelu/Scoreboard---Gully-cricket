//
//  OutcomeSectionView.swift
//  Scoreboard
//
//  Created by sankara velayutham on 20/07/23.
//

import SwiftUI
import RealmSwift

struct OutcomeSectionView: View {
    @EnvironmentObject var matchvariables: MatchVariables
    @ObservedRealmObject var innings: Innings
    
    @State private var isBallNotCounted = false
    @Binding var alertMatchCompleted: Bool
    
    // Outcomes
    let outcomeNumbers: [String] = ["0", "1", "2", "3", "4", "5", "6"]
    let outcomeOthers: [String] = ["No Ball", "Wide", "Wicket"]
    
    var body: some View {
        
        HStack {
            ForEach(outcomeNumbers, id: \.self) {num in
                
                OutcomeButton(text: "\(num)") {
                    if !(matchvariables.inningsCompleted && !matchvariables.chaseStarted) {
                        if  !matchvariables.chaseCompleted {
                            
                            addOutcome(outcome: num, ballcounted: !isBallNotCounted)
                            isBallNotCounted = false
                            
                            if matchvariables.chaseStarted {
                                if innings.runs >= matchvariables.target ||
                                    (innings.ballCounter ==
                                     matchvariables.numberOfOvers*6) {
                                    
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
            ForEach(outcomeOthers, id: \.self) {num in
                
                OutcomeButton(text: "\(num)" ) {
                    
                    if !(matchvariables.inningsCompleted && !matchvariables.chaseStarted) {
                        if  !matchvariables.chaseCompleted {
                            
                            switch num {
                                
                            case "No Ball":
                                addOutcome(outcome: "NB", ballcounted: false)
                                
                            case "Wide":
                                addOutcome(outcome: "Wd", ballcounted: false)
                            default:
                                addOutcome(outcome: "W", ballcounted: !isBallNotCounted)
                            }
                            
                            isBallNotCounted = false
                            
                            if matchvariables.chaseStarted {
                                if innings.runs >= matchvariables.target || (innings.ballCounter == matchvariables.numberOfOvers*6) {
                                    
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
                if matchvariables.inningsCompleted && !matchvariables.chaseStarted {
                    matchvariables.inningsCompleted.toggle()
                    matchvariables.saveMatchVariables()
                }
                
                // Case match over
                if matchvariables.chaseCompleted {
                    matchvariables.chaseCompleted.toggle()
                    matchvariables.saveMatchVariables()
                }
                
            }
        }
    }
    // -------------------------------------- Functions starts ------------------------------------
    
    // 1. func addOutcome
    
    private func addOutcome(outcome outcomeOfBall: String, ballcounted: Bool) {
        
        let outcome = Outcome()
        outcome.isBallCounted = ballcounted
        outcome.outcome = outcomeOfBall
        outcome.over = innings.currentOver
        
        $innings.inningsOutcome.append(outcome)
        
        guard let realm = try? Realm()
        else { return }
        guard let innings = realm.object(ofType: Innings.self, forPrimaryKey: innings.id)
        else { return }
        try? realm.write {
            
            switch outcomeOfBall {
                
            case "Wd":
                if matchvariables.runForWide {
                    innings.runs += 1
                }
            case "NB":
                if matchvariables.runForNoBall {
                    innings.runs += 1
                }
            case "W":
                if ballcounted {
                    innings.ballCounter += 1
                    innings.wickets += 1
                } else {
                    innings.wickets += 1
                }
            default:
                if ballcounted {
                    innings.ballCounter += 1
                    innings.runs += (Int(outcomeOfBall) ?? 0)
                } else {
                    innings.runs += (Int(outcomeOfBall) ?? 0)
                }
            }
        }
    }
    
    // 2. func undoOutcome
    
    private func undoOutcome() {
        
        if  innings.inningsOutcome.count != 0 {
            
            let  outcomeLast = innings.inningsOutcome[innings.inningsOutcome.count-1]
            let outCome = outcomeLast.outcome
            let isBallCounted = outcomeLast.isBallCounted
            
            guard let realm = try? Realm()
            else { return }
            guard let innings = realm.object(ofType: Innings.self, forPrimaryKey: innings.id)
            else { return }
            try? realm.write {
                
                if isBallCounted {
                    innings.ballCounter -= 1
                }
                switch outCome {
                    
                case "Wd":
                    if matchvariables.runForWide {
                        innings.runs -= 1
                    }
                case "NB":
                    if matchvariables.runForNoBall {
                        innings.runs -= 1
                    }
                case "W":
                    innings.wickets -= 1
                default:
                    innings.runs -= Int(outCome)!
                }
                
                realm.delete(innings.inningsOutcome.last!)
                //                   inningsOutcome.removeLast()
                
                return
            }
        }
    }
}

struct OutcomeSectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            let alert = false
            VStack {
                OutcomeSectionView(innings: Innings(), alertMatchCompleted: .constant(alert))
                    .environmentObject(MatchVariables())
            }
        }
    }
}

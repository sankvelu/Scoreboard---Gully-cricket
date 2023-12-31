//
//  Inninngs.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 08/06/23.
//

import Foundation
import SwiftUI
import RealmSwift

class Innings: Object, Identifiable {
    
    let matchVariables = MatchVariables.matchVariables
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var inningsOutcome: RealmSwift.List<Outcome> = RealmSwift.List<Outcome>() {
        didSet {
            matchVariables.saveMatchVariables()
        }
    }
    
    @Persisted var ballCounter: Int = 0
    @Persisted var runs: Int = 0
    @Persisted var wickets: Int = 0
    
    var currentOver: Int {
        (ballCounter/6) + 1
    }
    
    // Calculating overs bowled
    
    func oversBowled() -> (overs: Int, balls: Int) {
        
        let overs = ballCounter/6
        let balls = ballCounter%6
        
        return(overs, balls)
    }
    
    // Getting the overs count
    
    func getOversInString(totalOvers: String) -> String {
        
        let overs = String(ballCounter/6)
        let balls = String(ballCounter%6)
        
        return("\(overs).\(balls) (\(totalOvers))")
        
    }
    
    // Present over outcome
    
    func thisOver() -> [String] {
        
        var thisOverOutcome = [String]()
        var count = 0
        
        for outCome in inningsOutcome {
            
            if outCome.over == currentOver {
                
                if !outCome.isBallCounted {
                    
                    switch outCome.outcome {
                    case "0", "1", "2", "3", "4", "5", "6", "W":
                        thisOverOutcome.append(outCome.outcome+"Y"+"X\(count)")
                    default:
                        thisOverOutcome.append(outCome.outcome+"X\(count)")
                        
                    }
                } else {
                    thisOverOutcome.append(outCome.outcome+"X\(count)")
                }
                count += 1
            }
        }
        return thisOverOutcome
    }
    
    // Previous Over Outcome
    
    func previousOver() -> ([String], Int) {
        
        var previousOverOutcome = [String]()
        var previousOverRuns: Int = 0
        var count = 0
        
        for outCome in inningsOutcome {
            
            if outCome.over == currentOver-1 {
                
                if !outCome.isBallCounted {
                    
                    switch outCome.outcome {
                    case "0", "1", "2", "3", "4", "5", "6", "W":
                        previousOverOutcome.append(outCome.outcome+"Y"+"X\(count)")
                    default:
                        previousOverOutcome.append(outCome.outcome+"X\(count)")
                        
                    }
                } else {
                    previousOverOutcome.append(outCome.outcome+"X\(count)")
                }
                
                switch outCome.outcome {
                case "1", "2", "3", "4", "5", "6":
                    previousOverRuns += Int(outCome.outcome)!
                case "Wd":
                    if matchVariables.runForWide {
                        previousOverRuns += 1
                    }
                case "NB":
                    if matchVariables.runForNoBall {
                        previousOverRuns += 1
                    }
                default:
                    previousOverRuns += 0
                }
            }
            count += 1
        }
        return (previousOverOutcome, previousOverRuns)
    }
}

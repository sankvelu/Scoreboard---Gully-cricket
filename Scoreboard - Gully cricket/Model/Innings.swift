//
//  Inninngs.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 08/06/23.
//

import Foundation
import SwiftUI

class Innings: ObservableObject{
    
    @Published var inningsOutcome = [Outcome]() ;
    
    @Published var ballCounter:Int = 0;
    @Published var runs:Int = 0;
    @Published var wickets:Int = 0;
    
    var previousOverRuns : Int = 0;
    
    var currentOver : Int {
       (ballCounter/6) + 1;
    }

    
     func addOutcome(outcome outcomeOfBall:String, ballcounted: Bool){
        
        inningsOutcome.append(Outcome(outcome: outcomeOfBall, isBallCounted: ballcounted, over: currentOver))
        
//        print(inningsOutcome)
        
        switch(outcomeOfBall){
        case "NB","Wd":
            runs += 1
        case "W":
            if(ballcounted){
                ballCounter += 1
                wickets += 1
            }
            else{
                wickets += 1
            }
        default:
            if(ballcounted){
                ballCounter += 1;
                runs = runs + (Int(outcomeOfBall) ?? 0)
            }
            else {
                runs = runs + (Int(outcomeOfBall) ?? 0)
            }
        }
    }
    
    // Calculating overs bowled
    
    func oversBowled()->(overs:Int,balls:Int){
        
        let overs = ballCounter/6;
        let balls = ballCounter%6;
        
        return(overs,balls);
    }
    
    // Reversing the outcome
    
     func undoOutcome(){
        
        if( inningsOutcome.count != 0){
            
            let  outcomeLast = inningsOutcome[inningsOutcome.count-1]
//            print(outcomeLast)
            let outCome = outcomeLast.outcome
            let isBallCounted = outcomeLast.isBallCounted
            
            if(isBallCounted){
                ballCounter -= 1;
            }
            switch(outCome){
                
            case "NB","Wd":
                runs -= 1
            case "W":
                wickets -= 1
            default:
                runs = runs - Int(outCome)!
            }
            
            inningsOutcome.removeLast()
            
            return
        }
    }
    
    // Getting the overs count
    
    func getOversInString(totalOvers:String)->String{
        
        let overs = String(ballCounter/6);
        let balls = String(ballCounter%6);
        
        return("\(overs).\(balls) (\(totalOvers))")
        
    }
    
    // Present over outcome
    
    func thisOver()->[String]{
        
        var thisOverOutcome = [String]()
        
        for outCome in inningsOutcome {
            
            if(outCome.over == currentOver){
                
                if(!outCome.isBallCounted){
                    
                    switch(outCome.outcome){
                    case "1","2","3","4","5","6","W" :
                        thisOverOutcome.append(outCome.outcome+"NC")
                    default:
                        thisOverOutcome.append(outCome.outcome)
                        
                    }
                }else{
                    thisOverOutcome.append(outCome.outcome)
                }
                
            }
        }
        return thisOverOutcome
    }
    
    //Previous Over Outcome
    
    func previousOver()->[String]{
        
      var previousOverOutcome = [String]()
        
        for outCome in inningsOutcome {
            
            if(outCome.over == currentOver-1){
                
                //Copypaste start
                
                if(!outCome.isBallCounted){
                    
                    switch(outCome.outcome){
                    case "1","2","3","4","5","6","W" :
                        previousOverOutcome.append(outCome.outcome+"NC")
                    default:
                        previousOverOutcome.append(outCome.outcome)
                        
                    }
                }else{
                    previousOverOutcome.append(outCome.outcome)
                }
                //Copypaste end
                
                switch(outCome.outcome){
                case "1","2","3","4","5","6":
                    previousOverRuns = previousOverRuns + Int(outCome.outcome)!
                case "Wd","NB":
                    previousOverRuns = previousOverRuns + 1
                default:
                    previousOverRuns = previousOverRuns + 0
                }
            }
        }
        print(previousOverRuns)
        
        return previousOverOutcome
        
    }
   
}

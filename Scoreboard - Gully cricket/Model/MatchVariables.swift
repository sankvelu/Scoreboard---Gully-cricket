//
//  MatchVariables.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 12/06/23.
//

import SwiftUI

class MatchVariables : ObservableObject {
    
    static let matchVariables = MatchVariables()
    
    
    let defaults = UserDefaults.standard;
    
    @Published var numberOfOvers : Int = 5
    @Published var runForWide : Bool
    @Published var runForNoBall : Bool
    @Published var target:Int = 0
    
    @Published var matchStarted = false
    @Published var inningsCompleted = false
    @Published var chaseStarted = false
    @Published var chaseCompleted = false
    @Published var matchStartedAndCompleted = false {
        didSet{
            saveMatchVariables()
        }
    }
    
    
    init(){
        if(defaults.integer(forKey: "numberOfOvers") == 0){
            numberOfOvers = 5
        }
        else {
            numberOfOvers = defaults.integer(forKey: "numberOfOvers")
        }
        runForWide = defaults.bool(forKey: "runForWide")
        runForNoBall = defaults.bool(forKey: "runForNoBall")
        target = defaults.integer(forKey: "target")
        
        matchStarted = defaults.bool(forKey: "matchStarted")
        inningsCompleted = defaults.bool(forKey: "inningsCompleted")
        chaseStarted = defaults.bool(forKey: "chaseStarted")
        chaseCompleted = defaults.bool(forKey: "chaseCompleted ")
        matchStartedAndCompleted = defaults.bool(forKey: "matchStartedAndCompleted")
        
    }
    func variableStatus(){
        
        print(matchStarted, inningsCompleted, chaseStarted, chaseCompleted, matchStartedAndCompleted)
        
    }
    
    func saveMatchVariables() {
        defaults.set(numberOfOvers, forKey: "numberOfOvers")
        defaults.set(runForWide, forKey: "runForWide")
        defaults.set(runForNoBall, forKey: "runForNoBall")
        defaults.set(target, forKey: "target")
        
        
        defaults.set(matchStarted, forKey: "matchStarted")
        defaults.set(inningsCompleted, forKey: "inningsCompleted")
        defaults.set(chaseStarted, forKey: "chaseStarted")
        defaults.set(chaseCompleted , forKey: "chaseCompleted ")
        defaults.set(matchStartedAndCompleted, forKey: "matchStartedAndCompleted")
        
        
    }
    
    
    
    
    
    
    
}

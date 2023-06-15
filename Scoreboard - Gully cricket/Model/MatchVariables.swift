//
//  MatchVariables.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 12/06/23.
//

import SwiftUI

class MatchVariables : ObservableObject {
    
    
    @Published var numberOfOvers : Int = 1
    @Published var runForWide = true
    @Published var runForNoBall = true
    
    @Published var hasMatchStarted = false
    @Published var inningsCompleted = false
    @Published var chaseStarted = false
    @Published var matchCompleted = false
    
}

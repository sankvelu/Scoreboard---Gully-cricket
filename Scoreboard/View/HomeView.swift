//
//  HomeView.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 03/07/23.
//

import SwiftUI
import RealmSwift
struct HomeView: View {

    @EnvironmentObject var matchvariables: MatchVariables
    @ObservedResults(Innings.self) var innings

    var body: some View {
        VStack {
            if matchvariables.chaseStarted {
                if let innings2 = innings.last {
                    Matchview(innings: innings2)
                }
            } else {
                if let innings1 = innings.first {
                    Matchview(innings: innings1)
                }
            }
        }.onAppear(perform: toggleMatchStarted)
    }

    private func toggleMatchStarted() {
        if !matchvariables.matchStarted {
            matchvariables.matchStarted.toggle()
            matchvariables.saveMatchVariables()
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(MatchVariables())
    }
}

//
//  ScoreSectionView.swift
//  Scoreboard
//
//  Created by sankara velayutham on 20/07/23.
//

import SwiftUI
import RealmSwift

struct ScoreSectionView: View {
    @EnvironmentObject var matchvariables: MatchVariables
    @ObservedRealmObject var innings: Innings
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            
            HStack(spacing: 20) {
                
                ScoreBar(leftComp: "Overs", rightComp: innings.getOversInString(totalOvers: String(matchvariables.numberOfOvers)) )
                
                ScoreBar(leftComp: "Wickets", rightComp: String(innings.wickets))
                
            }
            
            HStack(spacing: 20) {
                
                ScoreBar(leftComp: "Runs", rightComp: String(innings.runs))
                
                if matchvariables.chaseStarted {
                    ScoreBar(leftComp: "Target", rightComp: String(matchvariables.target))
                }
            }
            
        }.padding(1)
    }
}

struct ScoreSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            ScoreSectionView(innings: Innings())
                .environmentObject(MatchVariables())
        }
    }
}

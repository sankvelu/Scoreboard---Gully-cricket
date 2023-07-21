//
//  ThisOverPreviousOverView.swift
//  Scoreboard
//
//  Created by sankara velayutham on 20/07/23.
//

import SwiftUI
import RealmSwift

struct ThisOverPreviousOverView: View {
    @EnvironmentObject var matchvariables: MatchVariables
    @ObservedRealmObject var innings: Innings
    
    @Binding var showingPreviousOver: Bool
    
    var body: some View {
        HStack {
            Text("This Over")
                .font(Font.title2)
                .padding(10)
                .background(.thinMaterial)
                .foregroundColor(Color.black)
                .border(Color("Neva"), width: 0.5)
                .cornerRadius(10)
            
            Button("Previous Over") {
                showingPreviousOver.toggle()
            }
            .font(Font.title2)
            .padding(10)
            .background(.ultraThinMaterial)
            .foregroundColor(Color.black)
            .cornerRadius(10)
            .sheet(isPresented: $showingPreviousOver) {
                
                let (previousOverOutcome, previousOverRuns) = innings.previousOver()
                
                PreviousOver(previousOverOutcome: previousOverOutcome, previousOverRuns: previousOverRuns)
            }
            
        }
        HStack {
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
    }
}

struct ThisOverPreviousOverView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            let alert = false
            VStack {
                ThisOverPreviousOverView(innings: Innings(), showingPreviousOver: .constant(alert))
                    .environmentObject(MatchVariables())
            }
        }
    }
}

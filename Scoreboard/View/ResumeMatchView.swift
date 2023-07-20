//
//  ResumeMatchView.swift
//  Scoreboard
//
//  Created by sankara velayutham on 20/07/23.
//

import SwiftUI

struct ResumeMatchView: View {
    @EnvironmentObject var matchvariables: MatchVariables
    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            NavigationLink(
                destination: HomeView(),
                label: {
                    Text("Resume Match")
                        .padding()
                        .font(Font.title)
                        .foregroundColor(.black)
                        .background(.ultraThickMaterial)
                        .border(Color.green, width: 0.15)
                        .cornerRadius(50)
                        .shimmering()

                }
            ).simultaneousGesture(TapGesture().onEnded {

            }).padding(20)

            Button("End Match?") {
                matchvariables.matchStartedAndCompleted.toggle()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
    }
}

struct ResumeMatchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            ResumeMatchView().environmentObject(MatchVariables())
        }
    }
}

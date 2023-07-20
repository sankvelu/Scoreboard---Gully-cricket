//
//  MatchView.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 09/06/23.
//

import SwiftUI
import RealmSwift

struct Matchview: View {

    @EnvironmentObject var matchvariables: MatchVariables
    @ObservedRealmObject var innings: Innings

    // Flags
    @State private var showingPreviousOver = false
    @State private var alertInningsCompleted = false
    @State var alertMatchCompleted = false

    @State private var isBouncing = false

    var body: some View {

        NavigationView {

            ZStack {

                Image("Grass")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                GeometryReader { geometry in
                    VStack(alignment: .center) {

                        Text(matchvariables.chaseStarted ? "2nd Innings":"1st Innings")
                            .font(Font.title)
                            .padding()
                            .background(.thinMaterial)
                            .foregroundColor(Color.black)
                            .clipShape(Rectangle())
                            .cornerRadius(20)
                            .padding(1)

                        ScoreSectionView(innings: innings)

                        VStack(alignment: .center) {

                            OutcomeSectionView(innings: innings, alertMatchCompleted: $alertMatchCompleted)

                        }.simultaneousGesture(TapGesture().onEnded {
                            if (!matchvariables.inningsCompleted)&&(!matchvariables.chaseStarted) {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if innings.ballCounter == matchvariables.numberOfOvers*6 {
                                        alertInningsCompleted.toggle()
                                        matchvariables.inningsCompleted.toggle()
                                        matchvariables.target = innings.runs + 1
                                        matchvariables.saveMatchVariables()
                                    }
                                }
                            }
                        })
                        .padding(20)
                        .background(.ultraThinMaterial.opacity(0.5))
                        .background(Color(uiColor: UIColor(red: 0.82, green: 1.00, blue: 0.74, alpha: 1.00)).opacity(0.2))
                        .border(.black, width: 0.15)
                        .cornerRadius(50)
                        .padding(.horizontal)

                        Spacer()

                        VStack {

                            ThisOverPreviousOverView(innings: innings, showingPreviousOver: $showingPreviousOver)

                            WrappedHStackView(words: innings.thisOver())
                                .padding(.bottom)
                        }

                        // Innings or Match completed stages

                        if matchvariables.inningsCompleted && !matchvariables.chaseStarted {
                            VStack(alignment: .center) {
                                OutcomeButton(text: "Start 2nd innings") {
                                    matchvariables.chaseStarted.toggle()
                                    matchvariables.saveMatchVariables()

                                }
                                .shimmering()
                                .background(.thinMaterial)
                                .cornerRadius(20)
                                .offset(y: -20)
                                .scaleEffect(isBouncing ? 1.2 : 1.0)
                                .animation(Animation.spring(response: 2.5, dampingFraction: 0.8, blendDuration: 0.5).repeatForever(autoreverses: false), value: isBouncing)
                            }.onAppear {
                                isBouncing = true // Start the bouncing animation when the view appears
                            }

                        }

                        if matchvariables.chaseCompleted {
                            VStack(alignment: .center) {
                                TextBar(textLabel: "Match Completed!")
                                    .shimmering()
                                    .background(.thinMaterial)
                                    .cornerRadius(10)

                            }
                        }
                        Spacer()
                    }.frame(maxWidth: geometry.size.width * 1)
                }
            }

            //  Ininngs completed Alert

            .alert("1st Innings Completed!", isPresented: $alertInningsCompleted) {
                Button("OK") {

                }
            }message: {
                Text("Target: \(innings.runs + 1)")
            }

            //  Match completed Alert

            .alert("Match Completed", isPresented: $alertMatchCompleted) {
                Button("OK") {

                }
            }message: {
                if innings.runs >= matchvariables.target {
                    Text("Target chased succesfully - Match won by Team Batting 2nd")
                } else if innings.runs == matchvariables.target-1 {
                    Text("Match Drawn :)")
                } else {
                    Text("Score defended succesfully - Match won by Team Batting 1st")
                }
            }
        }
    }

}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        Matchview(innings: Innings())
            .environmentObject(MatchVariables())
    }
}

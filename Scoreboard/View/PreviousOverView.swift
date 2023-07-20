//
//  PreviousOver.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 20/06/23.
//

import SwiftUI

struct PreviousOver: View {

    @Environment(\.dismiss) var dismiss

    var previousOverOutcome =  [String]()
    var previousOverRuns: Int

    var body: some View {
        NavigationView {
            ZStack {

                Image("PreviousOver")
                VStack(spacing: 10) {
                    Spacer()
                    Spacer(minLength: 400)
                    TextBar(textLabel: "Previous Over")
                    ScoreBar(leftComp: "Runs", rightComp: String(previousOverRuns))
                        .cornerRadius(20)
                    HStack {
                        HStack {
                            Circle()
                                .fill(Color("Voilet"))
                                .frame(width: 20, height: 20)
                                .padding(1)
                            Text("Ball Counted")
                                .foregroundColor(.white)
                                .padding(1)
                                .cornerRadius(20)
                        }
                        .padding(1)
                        .cornerRadius(10)

                        HStack {
                            Circle()
                                .fill(.cyan)
                                .frame(width: 20, height: 20)
                                .padding(1)
                            Text("Ball Not Counted")
                                .foregroundColor(.white)
                                .padding(1)
                                .cornerRadius(20)
                        }
                        .padding(1)
                        .cornerRadius(10)

                    }.padding(2)

                    WrappedHStackView(words: previousOverOutcome)
                        .frame(height: 500)
                        .padding(.horizontal)

                    Spacer()
                    Spacer()
                }
                .padding(50)
            }
            .toolbar {
                Button("x Close ") {
                    dismiss()
                }
                .font(Font.callout)
                .padding(5)
                .background(.ultraThinMaterial)
                .foregroundColor(.black)
                .cornerRadius(30)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PreviousOver_Previews: PreviewProvider {
    static var previews: some View {
        PreviousOver(previousOverOutcome: ["NB", "Wd", "W", "1", "6", "3"], previousOverRuns: 12)
    }
}

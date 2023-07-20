//
//  MatchvariablesPromptView.swift
//  Scoreboard
//
//  Created by sankara velayutham on 20/07/23.
//

import SwiftUI

struct MatchvariablesPromptView: View {

    @EnvironmentObject var matchvariables: MatchVariables

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {

            HStack {
                TextBar(textLabel: "Number of Overs ?")

                Picker("Number of overs ?", selection: $matchvariables.numberOfOvers) {
                    ForEach(1...50, id: \.self) {
                        Text("\($0) ")
                    }
                }
                .tint(.black)
                .pickerStyle(.automatic)
                .padding(3)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .padding(10)
            }

            HStack {
                TextBar(textLabel: "Run for wide ?")
                Toggle("", isOn: $matchvariables.runForWide)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 0.4)
                    )
                    .frame(width: 50)
                    .padding(10)
            }

            HStack {
                TextBar(textLabel: "Run for No Ball ?")
                Toggle("", isOn: $matchvariables.runForNoBall)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 0.4)
                    )
                    .frame(width: 50)
                    .padding(10)
            }

        }   .padding(20)
            .background(.ultraThinMaterial.opacity(0.5))
            .border(.black, width: 0.15)
            .cornerRadius(50)

    }
}

struct MatchvariablesPromptView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            MatchvariablesPromptView()
                .environmentObject(MatchVariables())
        }
    }
}

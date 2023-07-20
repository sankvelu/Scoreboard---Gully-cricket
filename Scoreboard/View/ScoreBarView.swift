//
//  ScoreBar.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 08/06/23.
//

import SwiftUI

struct ScoreBar: View {
    var leftComp: String
    var rightComp: String
    var body: some View {

        ZStack {
            Text("\(leftComp) : \(rightComp)")
                .padding(10)
                .font(Font.title2)
                .foregroundColor(.black)
                .background(.ultraThinMaterial)
                .border(Color.black, width: 0.1)
                .cornerRadius(10)

        }
    }
}

struct ScoreBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            ScoreBar(leftComp: "Score", rightComp: "45")
        }
    }
}

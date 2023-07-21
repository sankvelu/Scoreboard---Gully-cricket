//
//  OutcomeButton.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 07/06/23.
//

import SwiftUI

struct OutcomeButton: View {
    var text: String
    var clicked: (() -> Void) /// use closure for callback
    
    var body: some View {
        Button(action: clicked) { /// call the closure here
            HStack {
                Text(text) /// your text
            }
            .font(Font.title2)
            .padding(15)
            .foregroundColor(.black)
            .background(.thinMaterial)
            .border(Color.black, width: 0.15)
            .cornerRadius(15)
        }
    }
}

struct OutcomeButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            OutcomeButton(text: "LegByes") {
            }
        }
    }
}

//
//  TextBar.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 12/06/23.
//

import SwiftUI

struct TextBar: View {
    
    var textLabel: String
    
    var body: some View {
        Text(textLabel)
            .padding(10)
            .font(Font.title2)
            .foregroundColor(.black)
            .background(.ultraThinMaterial)
            .border(Color.black, width: 0.2)
            .cornerRadius(10)
    }
}

struct TextBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            TextBar(textLabel: "Some Text")
        }
    }
}

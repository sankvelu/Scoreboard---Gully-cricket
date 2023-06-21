//
//  PreviousOver.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 20/06/23.
//

import SwiftUI

struct PreviousOver: View {
    
    var previousOverOutcome =  [String]()
    var previousOverRuns : Int
    
    var body: some View {
        ZStack{
            Image("PreviousOver")
            VStack(spacing:10){
                Spacer()
                TextBar(textLabel: "Previous Over")
                ScoreBar(leftComp: "Runs", rightComp: String(previousOverRuns))
                    .cornerRadius(20)
                HStack{
                    HStack{
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
                    
                    HStack{
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
                    .padding(20)
                
                Spacer()
            }.padding(10)
            
        }
    }
}

struct PreviousOver_Previews: PreviewProvider {
    static var previews: some View {
        PreviousOver(previousOverOutcome: ["NB","Wd","W","1","6","3"], previousOverRuns: 12)
    }
}

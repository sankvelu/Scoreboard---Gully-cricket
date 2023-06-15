//
//  WrappedHStackView.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 15/06/23.
//

import SwiftUI


struct WrappedHStackView: View {
    
    var words =  [String]()
        
    var body: some View {
        TagsView(items: words)
    }
}

struct TagsView: View {
    let colors: [String: Color] = [ "NB":.teal, "Wd": .teal, "W": .red ]
    
    let items: [String]
    var groupedItems: [[String]] = [[String]]()
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [String]) {
        self.items = items
        self.groupedItems = createGroupedItems(items)
    }
    
    private func createGroupedItems(_ items: [String]) -> [[String]] {
        
        var groupedItems: [[String]] = [[String]]()
        var tempItems: [String] =  [String]()
        var width: CGFloat = 0
        
        for word in items {
            
            let label = UILabel()
            label.text = word
            label.sizeToFit()
            
            let labelWidth = label.frame.size.width + 32
            
            if (width + labelWidth + 55) < screenWidth {
                width += labelWidth
                tempItems.append(word)
            } else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(word)
            }
            
        }
        
        groupedItems.append(tempItems)
        return groupedItems
        
    }
    
    var body: some View {
        ScrollView {
        VStack(alignment: .leading) {
            
            ForEach(groupedItems, id: \.self) { subItems in
                HStack {
                    ForEach(subItems, id: \.self) { word in
                        Text(word)
                            .fixedSize()
                            .font(Font.caption)
                            .fontWeight(.bold)
                            .padding(15)
                            .background(colors[word, default: .black])
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                }
            }
            
            Spacer()
        }
    }
    }
    
}

struct WrappedHStackView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            WrappedHStackView(words: ["NB","Wd","W","1","6","3"])
        }.padding()
    }
}

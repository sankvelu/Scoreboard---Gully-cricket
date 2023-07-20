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
    let colors: [String: Color] = [ "NB": .yellow, "Wd": .yellow, "W": .red ]

    let items: [String]
    var groupedItems: [[String]] = [[String]]()
    let screenWidth = CGFloat(390)

    init(items: [String]) {
        self.items = items
        self.groupedItems = createGroupedItems(items)

    }

    private func createGroupedItems(_ items: [String]) -> [[String]] {

        var groupedItems: [[String]] = [[String]]()
        var tempItems: [String] =  [String]()
        var width: CGFloat = 0
        var count = 0

        for word in items {

            let label = UILabel()
            label.text = word
            label.sizeToFit()

            let labelWidth = label.frame.size.width

            if (width + labelWidth + CGFloat(10)) < screenWidth && count<6 {
                width += labelWidth
                tempItems.append(word)
                count += 1
            } else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(word)
                count = 1
            }

        }

        groupedItems.append(tempItems)
        return groupedItems

    }

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 10) {

                ForEach(groupedItems, id: \.self) { subItems in

                    HStack {
                        ForEach(subItems, id: \.self) { word in

                            let text = String(word.split(separator: "X").first!)

                            if text.contains("Y") {

                                let modifiedText = text.replacingOccurrences(of: "Y", with: "")

                                Text(modifiedText)
                                    .fixedSize()
                                    .font(Font.caption)
                                    .fontWeight(.bold)
                                    .frame(width: 15, height: 15)
                                    .padding(15)
                                    .background(.cyan)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))

                            } else {
                                Text(text)
                                    .fixedSize()
                                    .font(Font.caption)
                                    .fontWeight(.bold)
                                    .frame(width: 15, height: 15)
                                    .padding(15)
                                    .background(colors[text, default: Color("Voilet")])
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))

                            }
                        }
                    }.padding(4)
                }
                Spacer()
            }.padding(4)
        }
    }

}

struct WrappedHStackView_Previews: PreviewProvider {
    static var previews: some View {

        WrappedHStackView(words: ["NB", "Wd", "1", "6", "3", "2"])

    }
}

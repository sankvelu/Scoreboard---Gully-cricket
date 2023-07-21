//
//  ContentView.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 06/06/23.
//

import SwiftUI
import Shimmer
import RealmSwift

struct ContentView: View {
    
    @EnvironmentObject var matchvariables: MatchVariables
    @ObservedResults(Innings.self) var innings
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Image("Cricket")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in
                    VStack {
                        
                        Spacer(minLength: 50)
                        
                        Text("Scoreboard - Gully Cricket")
                            .padding()
                            .font(Font.title)
                            .foregroundColor(.black)
                            .background(.thinMaterial)
                            .border(Color.green, width: 0.15)
                            .cornerRadius(10)
                            .background(Color(uiColor: UIColor(red: 0.82, green: 1.00, blue: 0.74, alpha: 1.00)).opacity(0.3))
                        
                        // Match not started
                        
                        if !matchvariables.matchStarted {
                            
                            Spacer()
                            
                            VStack(alignment: .center, spacing: 50) {
                                
                                Spacer()
                                
                                MatchvariablesPromptView()
                                
                                NavigationLink(
                                    destination: HomeView(),
                                    label: {
                                        Text("Start Match")
                                            .padding()
                                            .font(Font.title)
                                            .foregroundColor(.black)
                                            .background(.ultraThickMaterial)
                                            .background(Color(uiColor: UIColor(red: 0.82, green: 1.00, blue: 0.74, alpha: 1.00)).opacity(0.5))
                                            .border(Color.green, width: 0.15)
                                            .cornerRadius(50)
                                            .shimmering()
                                        
                                    })
                                .simultaneousGesture(TapGesture().onEnded {
                                    if innings.isEmpty {
                                        let innings1 = Innings()
                                        $innings.append(innings1)
                                        let innings2 = Innings()
                                        $innings.append(innings2)
                                    }
                                }).padding()
                                
                                Spacer()
                                Spacer()
                            }
                            Spacer()
                        }
                        
                        // Match Started
                        
                        else {
                            ResumeMatchView()
                        }
                    }
                    .frame(maxWidth: geometry.size.width * 1 )
                }
                .alert("Discard match?", isPresented: $matchvariables.matchStartedAndCompleted) {
                    Button("End Match", role: .destructive) {
                        matchvariables.matchStarted.toggle()
                        if matchvariables.inningsCompleted {
                            matchvariables.inningsCompleted.toggle()
                        }
                        if matchvariables.chaseStarted {
                            matchvariables.chaseStarted.toggle()
                        }
                        if matchvariables.chaseCompleted {
                            matchvariables.chaseCompleted.toggle()
                        }
                        matchvariables.saveMatchVariables()
                        
                        clearRealm()
                        
                    }.cornerRadius(20)
                    
                }message: {
                    Text("Match progress will be lost")
                }
                
            }.preferredColorScheme(.light)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func clearRealm() {
        
        guard let realm = try? Realm() else {return}
        try? realm.write {
            // Delete all objects from the realm.
            realm.deleteAll()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MatchVariables())
    }
}

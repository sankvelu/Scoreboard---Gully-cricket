//
//  ContentView.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 06/06/23.
//

import SwiftUI

struct ContentView: View  {
    
    @EnvironmentObject var matchvariables: MatchVariables
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                
                //Section 1
                
                Image("Cricket")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                //Section 2
                
                VStack{
                    
                    Spacer(minLength: 50)
                    
                    Text("Scoreboard - Gully Cricket")
                        .padding()
                        .font(Font.title)
                        .foregroundColor(.black)
                        .background(.thinMaterial)
                        .border(Color.green, width:0.15)
                        .cornerRadius(10)
                        

                 if(!matchvariables.hasMatchStarted){
                     
                        Spacer()
                        
                        VStack(alignment: .center,spacing:50){
                            
                            Spacer()
                            
                            VStack(alignment: .leading,spacing:10){
                                
                                HStack{
                                    TextBar(textLabel: "Number of Overs ?")
                                    
                                    Picker("Number of overs ?", selection: $matchvariables.numberOfOvers){
                                        ForEach(1...50, id: \.self) {
                                            Text("\($0) ")
                                        }
                                    }
                                    .tint(.black)
                                    .pickerStyle(.automatic)
                                    .padding(3)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(15)
                                    .padding(15)
                                    
                                }
                                
                                HStack{
                                    TextBar(textLabel: "Run for wide ?")
                                    Toggle("", isOn: $matchvariables.runForWide)
                                        .frame(width: 50)
                                        .padding(10)
                                }
                                
                                HStack{
                                    TextBar(textLabel: "Run for No Ball ?")
                                    Toggle("", isOn: $matchvariables.runForNoBall)
                                        .frame(width: 50)
                                        .padding(10)
                                }
                                
                            }
                        
                            NavigationLink(
                                destination: Matchview(),
                                label: {
                                    Text("Start New Match")
                                        .padding()
                                        .font(Font.title)
                                        .foregroundColor(.black)
                                        .background(.thinMaterial)
                                        .border(Color.green, width:0.15)
                                        .cornerRadius(50)
                                }
                                
                            ).simultaneousGesture(TapGesture().onEnded {
                                matchvariables.hasMatchStarted.toggle()
                            }).padding()
                            
                            Spacer()
                            Spacer()
                            
                        }
                     
                        Spacer()
                        
                    }
                    
                    // Match Started
                    
                    else{
                        VStack(alignment: .center){
                            Spacer()
                            
                            NavigationLink(
                                destination: Matchview(),
                                label: {
                                    Text("Resume Match")
                                        .padding()
                                        .font(Font.title)
                                        .foregroundColor(.black)
                                        .background(.thinMaterial)
                                        .border(Color.green, width:0.15)
                                        .cornerRadius(50)

                                }
                            ).simultaneousGesture(TapGesture().onEnded {
                                print("NavigationLink clicked!")
                            }).padding(20)
                            
                            
                            Button("End Match?"){
                                matchvariables.matchCompleted.toggle()
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Spacer()
                        }
                    }
                    
                }
                .alert("Discard match?", isPresented: $matchvariables.matchCompleted){
                    Button("End Match", role: .destructive) {
                        matchvariables.hasMatchStarted.toggle()
                    }.cornerRadius(20)
                    
                }message: {
                    Text("Match progress will be lost")
                }
            }
        }.preferredColorScheme(.light)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MatchVariables())
    }
}



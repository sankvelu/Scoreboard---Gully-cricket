//
//  ContentView.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 06/06/23.
//

import SwiftUI
import Shimmer

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
                    
                   // Match not started

                 if(!matchvariables.matchStarted){
                     
                        Spacer()
                        
                        VStack(alignment: .center,spacing:50){
                            
                            Spacer()
                            
                            VStack(alignment: .leading,spacing:5){
                                
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
                                    .padding(10)
                                    
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
                                    Text("Start Match")
                                        .padding()
                                        .font(Font.title)
                                        .foregroundColor(.black)
                                        .background(.ultraThickMaterial)
                                        .border(Color.green, width:0.15)
                                        .cornerRadius(50)
                                        .shimmering()
                                        
                                }
                                
                            ).simultaneousGesture(TapGesture().onEnded {
                                matchvariables.matchStarted.toggle()
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
                                        .background(.ultraThickMaterial)
                                        .border(Color.green, width:0.15)
                                        .cornerRadius(50)
                                        .shimmering()

                                }
                            ).simultaneousGesture(TapGesture().onEnded {
                                print("NavigationLink clicked!")
                            }).padding(20)
                            
                            
                            Button("End Match?"){
                                matchvariables.matchStartedAndCompleted.toggle()
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Spacer()
                        }
                    }
                    
                }
                .alert("Discard match?", isPresented: $matchvariables.matchStartedAndCompleted){
                    Button("End Match", role: .destructive) {
                        matchvariables.matchStarted.toggle()
                        if(matchvariables.inningsCompleted){
                            matchvariables.inningsCompleted.toggle()
                        }
                        if(matchvariables.chaseStarted){
                            matchvariables.chaseStarted.toggle()
                        }
                        if(matchvariables.chaseCompleted){
                            matchvariables.chaseCompleted.toggle()
                        }
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



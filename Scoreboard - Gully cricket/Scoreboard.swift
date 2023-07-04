//___FILEHEADER___

import SwiftUI

@main
struct  Scoreboard:App {
    
    @StateObject var matchvariables = MatchVariables.matchVariables;
    let migrator = Migrator()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(matchvariables)
        }
    }
}

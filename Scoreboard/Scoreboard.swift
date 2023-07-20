// ___FILEHEADER___

import SwiftUI

@main
struct  Scoreboard: App {

    @StateObject var matchvariables = MatchVariables.matchVariables

    let migrator = RealmMigrator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(matchvariables)
        }
    }
}

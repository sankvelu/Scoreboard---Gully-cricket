//
//  Migrator.swift
//  ScoreboardDummy
//
//  Created by sankara velayutham on 29/06/23.
//

import Foundation
import RealmSwift

class RealmMigrator {
    init() {
        updateSchema()
    }
    func updateSchema() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config

        guard let _ = try? Realm() else {
            return
      }
    }
}

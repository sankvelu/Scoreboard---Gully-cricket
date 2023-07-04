//
//  Migrator.swift
//  ScoreboardDummy
//
//  Created by sankara velayutham on 29/06/23.
//

import Foundation
import RealmSwift

class Migrator {
    
    init() {
        updateSchema()
    }
    
    func updateSchema() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config

        let _ = try! Realm()
    }
    
}

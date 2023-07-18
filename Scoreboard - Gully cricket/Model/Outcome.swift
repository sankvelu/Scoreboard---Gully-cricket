//
//  Outcome.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 08/06/23.
//

import Foundation
import RealmSwift

class Outcome: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var outcome: String
    @Persisted var isBallCounted: Bool
    @Persisted var over: Int
    
    override class func primaryKey() -> String? {
        "id"
    }
   
}

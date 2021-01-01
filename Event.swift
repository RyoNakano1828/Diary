//
//  Event.swift
//  Diary
//
//  Created by NeppsStaff on 2021/01/01.
//

import Foundation
import RealmSwift

class Event: Object {
    
    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""
}

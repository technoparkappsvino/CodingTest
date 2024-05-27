//
//  University.swift
//  Assignment
//
//  Created by Vinoth Kumar GIRI on 27/05/24.
//

import RealmSwift

class University: Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var state: String? = ""
    @objc dynamic var country: String = ""
    @objc dynamic var alpha_two_code: String = ""
    @objc dynamic var web_pages: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
}



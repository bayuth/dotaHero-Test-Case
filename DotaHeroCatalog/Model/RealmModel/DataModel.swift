//
//  DataModel.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 10/01/22.
//

import Foundation
import RealmSwift

class DataModel: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var img: String = ""
    @objc dynamic var localized_name: String = ""
    @objc dynamic var primary_attr: String = ""
    @objc dynamic var attack_type: String = ""
    var roles = List<String>()
    @objc dynamic var base_health: Int = 0
    @objc dynamic var base_mana: Int = 0
    @objc dynamic var base_armor: Double = 0.0
    @objc dynamic var base_attack_min: Int = 0
    @objc dynamic var base_attack_max: Int = 0
    @objc dynamic var move_speed: Int = 0
}

//class RoleObject: Object{
//    @objc dynamic var role = ""
//}

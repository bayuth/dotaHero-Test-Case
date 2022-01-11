//
//  HeroMode.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 09/01/22.
//

import Foundation

struct Hero: Codable{
    let id: Int
    let img: String
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let roles: [String]
    let base_health: Int
    let base_mana: Int
    let base_armor: Double
    let base_attack_min: Int
    let base_attack_max: Int
    let move_speed: Int
}

struct Role{
    let roleName: String
}

var roles = ["All" ,"\(RoleList.carry)", "\(RoleList.disabler)", "\(RoleList.durable)", "\(RoleList.escape)", "\(RoleList.jungler)", "\(RoleList.nuker)", "\(RoleList.pusher)", "\(RoleList.support)"]

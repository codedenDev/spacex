//
//  Company.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation

struct Company:Codable {
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let launchSites: Int
    let valuation: Int
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case founder = "founder"
        case founded = "founded"
        case employees = "employees"
        case launchSites = "launch_sites"
        case valuation = "valuation"
        case id = "id"
    }
}

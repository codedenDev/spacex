//
//  Launch.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation

// MARK: - Launch
struct Launch: Codable, Identifiable {
    let links: Links
    let staticFireDateUtc: String?
    let staticFireDateUnix: Int?
    let rocket: String
    let success: Bool?
    let name: String
    let dateUtc: String
    let dateUnix: Int
    let datePrecision: String
    let id: String
    var rocketDetails: Rocket?
    
    enum CodingKeys: String, CodingKey {
        case links = "links"
        case staticFireDateUtc = "staticFireDateUtc"
        case staticFireDateUnix = "staticFireDateUnix"
        case rocket = "rocket"
        case success = "success"
        case name = "name"
        case dateUtc = "date_utc"
        case dateUnix = "date_unix"
        case datePrecision = "date_precision"
        case id = "id"
    }
}


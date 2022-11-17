//
//  Links.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation


// MARK: - Links
struct Links: Codable {
    let patch: Patch
    let presskit: String?
    let webcast: String?
    let youtubeId: String?
    let article: String?
    let wikipedia: String?
    
    enum CodingKeys: String, CodingKey {
        case patch = "patch"
        case presskit = "presskit"
        case webcast = "webcast"
        case youtubeId = "youtube_id"
        case article = "article"
        case wikipedia = "wikipedia"
    }
}

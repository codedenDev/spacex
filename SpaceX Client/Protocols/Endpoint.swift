//
//  Endpoint.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

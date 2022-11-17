//
//  SpaceXService.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation

extension Endpoint {
    var baseURL: String {
        return "https://api.spacexdata.com"
    }
}

protocol SpaceXServiceable{
    func getCompanyInfo() async -> Result<Company, RequestError>
    func getLaunches() async -> Result<[Launch], RequestError>
    func getRocket(id:String) async -> Result<Rocket, RequestError>
}

struct SpaceXService: HTTPClient, SpaceXServiceable{
    func getRocket(id:String) async -> Result<Rocket, RequestError> {
        return await sendRequest(endpoint: SpaceXEndpoint.rockets(id: id), responseModel: Rocket.self)
    }
    
    func getLaunches() async -> Result<[Launch], RequestError> {
        return await sendRequest(endpoint: SpaceXEndpoint.launches, responseModel: [Launch].self)
    }
    
    func getCompanyInfo() async -> Result<Company, RequestError> {
        return await sendRequest(endpoint: SpaceXEndpoint.companyInfo, responseModel: Company.self)
    }
}

//
//  SpaceXServiceMock.swift
//  SpaceX ClientTests
//
//  Created by Richard on 28/06/2022
//

import Foundation
@testable import SpaceX_Client

class SpaceXServiceMock: Mockable, SpaceXServiceable{
    
    var shouldFail:Bool = false
    
    func getCompanyInfo() async -> Result<SpaceX_Client.Company, SpaceX_Client.RequestError> {
        if shouldFail{
            return .failure(.decode)
        }
        return .success(loadJSON(filename: "Company", type: Company.self))
    }
    
    func getLaunches() async -> Result<[SpaceX_Client.Launch], SpaceX_Client.RequestError> {
        if shouldFail{
            return .failure(.decode)
        }
        return .success(loadJSON(filename: "Launches", type: [Launch].self))
    }
    
    func getRocket(id: String) async -> Result<SpaceX_Client.Rocket, SpaceX_Client.RequestError> {
        if shouldFail{
            return .failure(.decode)
        }
        return .success(loadJSON(filename: "Rocket", type: Rocket.self))
    }
    
}

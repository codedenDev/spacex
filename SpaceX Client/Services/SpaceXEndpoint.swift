//
//  SpaceXEndpoint.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022.
//

import Foundation

enum SpaceXEndpoint{
    case companyInfo
    case launches
    case rockets(id:String)
}

extension SpaceXEndpoint: Endpoint{
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var path: String{
        switch self{
        case .companyInfo:
            return "/v4/company"
        case .launches:
            return "/v4/launches"
        case .rockets(let id):
            return "/v4/rockets/\(id)"
        }
    }
    
    var method: RequestMethod{
        switch self{
        case  .companyInfo,.launches, .rockets:
            return .get
        }
    }
    
    

}


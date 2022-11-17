//
//  LaunchViewModel.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation
import UIKit

class LaunchViewModel: ObservableObject{
   @Published var launch: Launch
    private let spaceXService: SpaceXServiceable

    init(launch: Launch, spaceXService: SpaceXServiceable = SpaceXService()) {
        self.launch = launch
        self.spaceXService = spaceXService
        Task{
            await queryRocketData()
        }
    }
    
    func getDateAndTime()-> String{
        let date = Date(timeIntervalSince1970: TimeInterval(launch.dateUnix))
        return "\(date.getDate()) at \(date.getTime())"
    }

    
    func getDaysSinceOrFrom(now:Date = Date())-> String{
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: TimeInterval(launch.dateUnix))
        print(now,date)
        let components = calendar.dateComponents([.day], from: now, to: date)
        if let day = components.day{
            if day == 0 {
                return "Launching today!"
            }
            else if day < 0{
                return "Days since now: \(String(day).replacingOccurrences(of: "-", with: ""))"
            } else{
                return "Days from now: \(String(day))"
            }
        } else{
            return "Unknown"
        }
    }
    
    func queryRocketData() async{
            let result = await self.spaceXService.getRocket(id: launch.rocket)
            switch result {
            case .success(let rocket):
                DispatchQueue.main.async { [self] in
                    launch.rocketDetails = rocket
                }
            case .failure(let error):
                print(error)
            }
    }
}

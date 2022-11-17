//
//  LaunchesViewModel.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation

class LaunchesViewModel: ObservableObject{
    
    private let spaceXService: SpaceXServiceable
    @Published var launches = [Launch]()
    
    var selectedLaunch: Launch?
    let successfulOnly: Bool
    let sortOrder: SortOrder
    let yearSelection: Int
    
    init(spaceXService: SpaceXServiceable = SpaceXService(), successfulOnly: Bool, yearSelection:Int, sortOrder:SortOrder) {
        self.spaceXService = spaceXService
        self.successfulOnly = successfulOnly
        self.yearSelection = yearSelection
        self.sortOrder = sortOrder
        Task {
            await getLaunches()
        }
       
    }
    
    func getLaunches() async {
            let result = await spaceXService.getLaunches()
            switch result {
            case .success(let launches):
                storeAndSort(launches: launches)
            case .failure(let error):
                print(error)
            }
    }
    
    private func storeAndSort(launches: [Launch]){
        var displayLaunches = [Launch]()
        
        if sortOrder == .asc{
            displayLaunches = launches.sorted { $0.dateUnix < $1.dateUnix }
        } else{
            displayLaunches = launches.sorted { $0.dateUnix > $1.dateUnix }
        }
        
        if successfulOnly{
            displayLaunches = displayLaunches.filter{ launch in
                return launch.success == true
            }
        }
        if yearSelection > 0{
            displayLaunches = displayLaunches.filter{ launch in
                let launchDate = Date(timeIntervalSince1970: TimeInterval(launch.dateUnix))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy"
                let yearString = dateFormatter.string(from: launchDate)
                return yearString == String(yearSelection)
            }
        }
        
        self.launches = displayLaunches
    }
    
    
}

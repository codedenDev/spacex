//
//  SpaceX_ClientTests.swift
//  SpaceX ClientTests
//
//  Created by Richard on 28/06/2022
//

import XCTest
@testable import SpaceX_Client

@MainActor final class LaunchesViewModelSpec: XCTestCase {

    var vm: LaunchesViewModel?

    func testGetLaunchesSuccess() async throws {
        let spaceXService = SpaceXServiceMock()
        spaceXService.shouldFail = false
        vm = LaunchesViewModel(spaceXService: spaceXService, successfulOnly: false, yearSelection: 2020, sortOrder: .asc)
        await vm?.getLaunches()
        
        XCTAssert(vm?.launches.count ?? 0 > 1)
    }
    
    func testGetLaunchesFailure() async throws {
        let spaceXService = SpaceXServiceMock()
        spaceXService.shouldFail = true
        vm = LaunchesViewModel(spaceXService: spaceXService, successfulOnly: false, yearSelection: 2020, sortOrder: .asc)
        await vm?.getLaunches()
        
        XCTAssert(vm?.launches.count ?? 0 == 0)
    }
    
    func testLaunchesSuccessOnly() async throws {
        let spaceXService = SpaceXServiceMock()
        spaceXService.shouldFail = false
        vm = LaunchesViewModel(spaceXService: spaceXService, successfulOnly: true, yearSelection: -1, sortOrder: .asc)
        await vm?.getLaunches()
        
        for launch in vm!.launches{
            if launch.success == false{
                XCTFail("Failing: unsuccessful launch found")
            }
        }
            
    }
    
    func testLaunchesSpecificYearOnly() async throws {
        let spaceXService = SpaceXServiceMock()
        spaceXService.shouldFail = false
        vm = LaunchesViewModel(spaceXService: spaceXService, successfulOnly: false, yearSelection: 2022, sortOrder: .asc)
         await vm?.getLaunches()
        
        for launch in vm!.launches{
            let launchDate = Date(timeIntervalSince1970: TimeInterval(launch.dateUnix))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            let yearString = dateFormatter.string(from: launchDate)
            if yearString != "2022"{
                XCTFail("Failing: rogue date found")
            }
        }
    }

    func testLaunchesSortedAsc() async throws {
        let spaceXService = SpaceXServiceMock()
        spaceXService.shouldFail = false
        vm = LaunchesViewModel(spaceXService: spaceXService, successfulOnly: true, yearSelection: -1, sortOrder: .asc)
        await vm?.getLaunches()
        
        let firstItem = vm?.launches.first
        let lastItem = vm?.launches.last
        XCTAssert(firstItem!.dateUnix < lastItem!.dateUnix)
    }
    
    func testLaunchesSortedDesc() async throws {
        let spaceXService = SpaceXServiceMock()
        spaceXService.shouldFail = false
        vm = LaunchesViewModel(spaceXService: spaceXService, successfulOnly: true, yearSelection: -1, sortOrder: .desc)
        await vm?.getLaunches()
        
        let firstItem = vm?.launches.first
        let lastItem = vm?.launches.last
        XCTAssert(firstItem!.dateUnix > lastItem!.dateUnix)
    }


}

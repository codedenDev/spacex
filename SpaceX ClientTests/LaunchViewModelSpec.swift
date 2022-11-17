//
//  BiographyViewModelSpec.swift
//  SpaceX ClientTests
//
//  Created by Richard on 28/06/2022
//

import XCTest
@testable import SpaceX_Client

@MainActor final class LaunchViewModelSpec: XCTestCase {
    
    var vm:LaunchViewModel!
    var spaceXService = SpaceXServiceMock()
    var launch: Launch!
    override func setUpWithError() throws {
        let patch = Patch(small: nil, large: nil)
        let links = Links(patch: patch, presskit: nil, webcast: nil, youtubeId: nil, article: nil, wikipedia: nil)
        launch = Launch(links: links, staticFireDateUtc: nil, staticFireDateUnix: nil, rocket: "123", success: true, name: "Test Launch", dateUtc: "", dateUnix: Int(NSDate().timeIntervalSince1970), datePrecision: "", id: "")
        
    }
    
    
    func testGetCompanyInfoSuccess() async throws {
        spaceXService.shouldFail = false
        vm = LaunchViewModel(launch: launch, spaceXService: spaceXService)
        await vm!.queryRocketData()
        XCTAssert(vm!.launch.rocketDetails?.type != nil)
        XCTAssert(vm!.launch.rocketDetails?.name != nil)
    }
    
    func testGetCompanyInfoFail() async throws {
        spaceXService.shouldFail = true
        vm = LaunchViewModel(launch: launch, spaceXService: spaceXService)
        await vm!.queryRocketData()
        XCTAssert(vm!.launch.rocketDetails?.type == nil)
        XCTAssert(vm!.launch.rocketDetails?.name == nil)
    }
    
    func testGetDateAndTime() throws {
        vm = LaunchViewModel(launch: launch, spaceXService: spaceXService)
        let currentDateAndTime = Date(timeIntervalSince1970: TimeInterval(launch.dateUnix))
        let expectedString = "\(currentDateAndTime.getDate()) at \(currentDateAndTime.getTime())"
        let dateAndTime = vm.getDateAndTime()
        XCTAssert(dateAndTime == expectedString)
    }
    
    func testGetDaysSinceOrFromToday() throws{
        vm = LaunchViewModel(launch: launch, spaceXService: spaceXService)
        let expectedString = "Launching today!"
        XCTAssert(vm.getDaysSinceOrFrom() == expectedString)
    }
    
    func testGetDaysSinceOrFromFuture() throws{
        vm = LaunchViewModel(launch: launch, spaceXService: spaceXService)
        let expectedString = "Days from now: 4"
        print(vm.getDaysSinceOrFrom(now: Date().daysBefore))
        XCTAssert(vm.getDaysSinceOrFrom(now: Date().daysBefore) == expectedString)
    }
    
    func testGetDaysSinceOrFromPast() throws{
        vm = LaunchViewModel(launch: launch, spaceXService: spaceXService)
        let expectedString = "Days since now: 5"
        print(vm.getDaysSinceOrFrom(now: Date().daysAfter))
        XCTAssert(vm.getDaysSinceOrFrom(now: Date().daysAfter) == expectedString)
    }
    
    
}


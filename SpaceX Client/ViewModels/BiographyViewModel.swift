//
//  BiographyViewModel.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation

class BiographyViewModel: ObservableObject{
    
    private let spaceXService: SpaceXServiceable
    @Published var biograpghy: String = ""
    @Published var failedToGetCompany:Bool = false
    
    init(spaceXService: SpaceXServiceable = SpaceXService()) {
        self.spaceXService = spaceXService
        Task{
            await getCompanyInfo()
        }
    }
    
    func getCompanyInfo() async{
            let result = await spaceXService.getCompanyInfo()
            switch result {
            case .success(let company):
                biograpghy = formatBiography(company: company)
            case .failure(let error):
                print(error)
                DispatchQueue.main.async { [self] in
                    failedToGetCompany = true
                }
            }
        }
    
    private func formatBiography(company:Company) ->String{
        print("\(company.name) was founded by \(company.founder) in \(company.founded). It has now \(company.employees) employees, \(company.launchSites) launch sites, and is valued at USD \(company.valuation)")
        return "\(company.name) was founded by \(company.founder) in \(company.founded). It has now \(company.employees) employees, \(company.launchSites) launch sites, and is valued at USD \(company.valuation)"
    }
}

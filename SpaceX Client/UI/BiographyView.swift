//
//  BiographyView.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import SwiftUI

struct BiographyView: View {
    @ObservedObject var vm: BiographyViewModel
    
    var body: some View {
        vm.failedToGetCompany ? Text("Something went wrong 😞") : Text(vm.biograpghy)
    }
}

struct BiographyView_Previews: PreviewProvider {
    static var previews: some View {
        BiographyView(vm: BiographyViewModel())
    }
}


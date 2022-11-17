//
//  LaunchView.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import SwiftUI
import CachedAsyncImage
struct LaunchView: View {
    @ObservedObject var vm: LaunchViewModel
    
    var body: some View {
        HStack{
            VStack{
                CachedAsyncImage(url: URL(string: vm.launch.links.patch.small ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 60, height: 60)
                Spacer()

            }.padding(.trailing, 4)
            VStack(alignment: .leading){
                Text("Mission: \(vm.launch.name)")
                    .font(.system(size: 14))
                Text("Date/Time: \(vm.getDateAndTime())")
                    .font(.system(size: 14))
                Text("Rocket: \(vm.launch.rocketDetails?.name ?? "") - \(vm.launch.rocketDetails?.type ?? "")")
                    .font(.system(size: 14))
                Text(vm.getDaysSinceOrFrom())
                    .font(.system(size: 14))
                Spacer()
            }
            Spacer()
            VStack{
                Text(vm.launch.success ?? false ? "✅" : "❌")
                    .font(.system(size: 23))
                Spacer()
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesView(vm: LaunchesViewModel(successfulOnly: false, yearSelection: 2000, sortOrder: .asc))
    }
}

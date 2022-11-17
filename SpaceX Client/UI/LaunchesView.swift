//
//  LaunchesView.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import SwiftUI

struct LaunchesView: View {
    @ObservedObject var vm: LaunchesViewModel
    @State private var showingLinks = false
    
    var body: some View {
        List(vm.launches){ launch in
            LaunchView(vm: LaunchViewModel(launch: launch))
                .onTapGesture() {
                    vm.selectedLaunch = launch
                    showingLinks = true
                }
                .sheet(isPresented: $showingLinks) {
                    VStack(spacing: 16){
                        if let wikiUrl = URL(string: vm.selectedLaunch?.links.wikipedia ?? ""){
                            Link("Go to wikipedia", destination: wikiUrl)
                        }
                        if let articleUrl = URL(string: vm.selectedLaunch?.links.article ?? ""){
                            Link("Go to article", destination: articleUrl)
                        }
                        if let webcastUrl = URL(string: vm.selectedLaunch?.links.webcast ?? ""){
                            Link("Go to webcast", destination: webcastUrl)
                        }
                    }
                    .presentationDetents([.height(200)])
                }
        }.listStyle(.plain)
    }
}


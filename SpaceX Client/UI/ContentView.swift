//
//  ContentView.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import SwiftUI


struct ContentView: View {
    @State private var showingFilter = false
    @State private var successfullOnly = false
    @State private var specificYear = false{
        didSet{
            if specificYear == false{
                yearSelection = -1
            }
        }
    }
    @State private var yearSelection:Int = -1
    @State private var sortOrder:SortOrder = .asc
    private var sortOptions:[SortOrder] = [.asc, .desc]
    
    var body: some View {
        NavigationView{
            VStack {
                SectionHeader(title: "Company")
                BiographyView(vm: BiographyViewModel())
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 8)
                SectionHeader(title: "Launches")
                LaunchesView(vm: LaunchesViewModel(successfulOnly: successfullOnly, yearSelection: yearSelection, sortOrder: sortOrder))
                Spacer()
            }
            .sheet(isPresented: $showingFilter) {
                Form{
                    Toggle("Show successful launches only", isOn: $successfullOnly)
                    Picker("Sort by date", selection: $sortOrder) {
                        ForEach(sortOptions , id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    Toggle("Specific year?", isOn: $specificYear)
                    if specificYear{
                        Picker("Select year", selection: $yearSelection) {
                            ForEach(2006...2025, id: \.self) {
                                Text(String($0))
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                    }
                }
                .presentationDetents([.medium, .large])
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 24.67)
                        .padding(.leading, 32)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingFilter = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

enum SortOrder:String {
    case asc = "Ascending"
    case desc = "Descending"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


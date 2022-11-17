//
//  SectionHeader.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import SwiftUI

struct SectionHeader: View {
    var title: String = ""
    
    var body: some View {
        ZStack{
            Color("AccentColor")
            HStack{
                Text(title)
                    .foregroundColor(.white)
                    .padding(.leading, 16)
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }
        }.frame(height: 30)
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader()
    }
}


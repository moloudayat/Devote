//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Moloud on 11/16/25.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
       Image("rocket")
            .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .resizable()
            .scaledToFit()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}

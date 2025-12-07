//
//  BlankView.swift
//  Devote
//
//  Created by Moloud on 12/7/25.
//

import SwiftUI

struct BlankView: View {
    // MARK: - PROPERTY
    // MARK: - BODY
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        .opacity(0.5)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - PREVIEW
#Preview {
    BlankView()
}

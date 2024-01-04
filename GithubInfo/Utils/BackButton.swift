//
//  BackButton.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import SwiftUI

struct BackButton: View {
    @EnvironmentObject var router: Router
    var body: some View {
        Button(action: { router.navigateBack() }, label: {
            Image(systemName: "chevron.left")
            .foregroundColor(.black)
                .contentShape(Rectangle())

        })
        
        .foregroundColor(.white)
    }
}

#Preview {
  VStack {
    BackButton()
  }
}

//
//  ContentView.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import SwiftUI

struct SearchView: View {
  @State private var searchText: String = ""
  @State private var displayError = false
  @EnvironmentObject var router: Router
  
  var body: some View {
    ZStack(alignment: .top) {
      Color.black.opacity(0.2)
      VStack(alignment: .center) {
        
        Image(AssetImage.githubLogo)
          .padding(.top, 100.responsiveHeight())
          .padding(.bottom, 20)
        
        Text(String.StringKey.pleaseEnterUserName.rawValue)
          .rmNueueBold(25)
          .black()
          .centerText()
          .frame(width: 330.responsiveWidth())
          .padding()

        ZStack {
          RoundedRectangle(cornerRadius: 20.responsiveHeight())
            .foregroundColor(.black)
            .frame(height: 40.responsiveHeight())
          
          HStack {
            Image(systemName: "magnifyingglass")
              
              .foregroundColor(.white)
              .padding(.leading, 10)
            
            TextField("", text: $searchText)
              .foregroundColor(.white)
              .overlay(
                Text(String.StringKey.username.rawValue)
                  .rmNueueRegular(20)
                  .white()
                  .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                .opacity(searchText.isEmpty ? 1 : 0))
              
              .padding(.trailing, 40)
              .padding(.vertical, 8)
          }
        }
        .padding(.horizontal, 20)
        Button(action: {
          if !searchText.isEmpty {
            router.navigate(to: .userDetails(searchText))
            searchText = ""
            displayError = false
            
          }else{
            displayError = true
          }
        }) {
          Text(String.StringKey.search.rawValue)
              .rmNueueRegular(20)
              .white()
              .padding(.vertical, 10)
              .frame(maxWidth: .infinity)
              .background(Color.black)
              .cornerRadius(30.responsiveHeight())
        }
        .padding()
        
        if displayError {
          Text("Please enter a username!")
            .rmNueueRegular(15)
            .foregroundColor(.red)
        }
        
        
        
      }
      
    }
    .ignoresSafeArea()
    .ignoresSafeArea(.keyboard)
  .navigationBarBackButtonHidden(true)
  }
}

#Preview {
  SearchView()
}

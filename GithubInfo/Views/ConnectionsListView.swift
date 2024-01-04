//
//  ConnectionsListView.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import SwiftUI

struct ConnectionsListView: View {
  
  @StateObject var userVm: UserViewModel
  @EnvironmentObject var router: Router
  
  var body: some View {
    ZStack(alignment: .top) {
      Color.black.opacity(0.2)
      switch userVm.status {
      case .success:
        VStack{
          HStack {
            BackButton()
              .padding(.leading, 20)
              .padding(.trailing, 30.responsiveWidth())
            Text(userVm.selectedConnectionType.capitalized)
              .rmNueueBold(30)
            Spacer()
            
          }
          .padding(.top, 100.responsiveHeight())
          
          ScrollView {
            VStack(spacing: 20) {
              ForEach(0..<userVm.connections.count, id: \.self) { index in
                UserHeadingButton(logo: userVm.connections[index].avatarURL ?? "", name: userVm.connections[index].login,
                                  onTap: {
                  let username = userVm.connections[index].login
                  Task{
                    await userVm.getUserDetails(username:username)
                    router.navigate(to: .userDetails(username))
                  }
                }
                )
              }
            }
            .padding(.bottom, 40.responsiveHeight())
          }
          .padding(.top, 30.responsiveHeight())
          
        }
      case .loading:
        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.leading, 160.responsiveHeight())
      case .error(let string):
        HStack{
          BackButton()
            .padding(.leading, 30.responsiveWidth())
          Text("USER NOT FOUND!")
            .rmNueueBold(50)
            .foregroundColor(.red)
            .centerText()
            .padding(.leading, 10.responsiveWidth())
            
        }
      case .initial:
          HStack{}
      }
      
    }
    .ignoresSafeArea()
    .navigationBarBackButtonHidden()
  }
}

#Preview {
  ConnectionsListView(userVm: DependencyInjector().userVm)
}

struct UserHeadingButton: View {
  var logo : String
  var name : String
  var onTap: () -> Void
  
  var body: some View {
    Button(action: onTap, label: {
      ZStack {
        RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
        HStack{
          CachedAsyncImage(url: URL(string: logo)) {
              image in
              image
                  .resizable()
                  .renderingMode(.original)
          }
          placeholder: {
            Image(systemName: "person.fill")
              
                  
        }.frame(width: 20.responsiveWidth(), height: 20.responsiveHeight())
          
          Text(name)
            .rmNueueBold(18)
            .black()
            .padding(.leading, 10)
            .padding(.trailing, 30.responsiveWidth())
        }
      }
    })
    .frame(height: 50)
    .padding(.horizontal, 30.responsiveWidth())
  }
}

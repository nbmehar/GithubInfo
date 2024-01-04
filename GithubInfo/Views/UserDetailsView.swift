//
//  UserDetailsView.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import SwiftUI

struct UserDetailsView: View {
  
  @StateObject var userVm: UserViewModel = UserViewModel(userService: UserService(networkManager: NetworkManager.shared))
  @EnvironmentObject var router: Router
  var username: String
  
  var body: some View {
    ZStack(alignment: .leading) {
      Color.black.opacity(0.2)
      
      switch userVm.status {
      case .success:
        ScrollView{
          HStack{
            BackButton().padding(.trailing, 20)
            CachedAsyncImage(url: URL(string: userVm.userDetails?.avatarURL ?? "")) {
                image in
                image
                    .resizable()
                    .renderingMode(.original)
            }
            placeholder: {
              Image(systemName: "person.fill")
                    
          }.frame(width: 50.responsiveWidth(), height: 50.responsiveHeight())
            
            Text(userVm.userDetails?.login ?? "nil")
              .rmNueueBold(38)
              .black()
              .padding(.leading, 10)
            Spacer()
          }
          .padding(.top, 100.responsiveHeight())
          
          
          HStack {
            Text(String.StringKey.name.rawValue + " : " + (userVm.userDetails?.name ?? ""))
                .rmNueueBold(28)
              
            Spacer()
          }
          .padding(.top, 40.responsiveHeight())
          
          HStack {
            Text(String.StringKey.bio.rawValue + " : " + (userVm.userDetails?.bio ?? ""))
              .rmNueueBold(28)
            Spacer()
          }
          .padding(.top, 40.responsiveHeight())
          
          
          ConnectionsButton(label : String.StringKey.followers.rawValue.capitalized, onTap: {
            Task{
              userVm.selectedConnectionType = String.StringKey.followers.rawValue
              await userVm.getConnections(username: username)
            }
            router.navigate(to: .connectionsListView(userVm))
          }, count: String(userVm.userDetails?.followers ?? 0))
            .padding(.top, 40.responsiveHeight())
          
          ConnectionsButton(label : String.StringKey.following.rawValue.capitalized,
          onTap: {
            Task{
              userVm.selectedConnectionType = String.StringKey.following.rawValue
              await userVm.getConnections(username: username)
            }
            router.navigate(to: .connectionsListView(userVm))
          }, count: String(userVm.userDetails?.following ?? 0))
            .padding(.top, 20)
        }
        .padding(.horizontal, 30)
      case .loading:
        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.leading, 160.responsiveHeight())
      case .error(_):
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
          HStack{ }
        
      }
      
    }
    .ignoresSafeArea()
    .navigationBarBackButtonHidden()
    .onAppear {
                // Fetch data from the API when the view appears
                Task {
                    await userVm.getUserDetails(username: username)
                }
            }
  }
}

#Preview {
  UserDetailsView(userVm: DependencyInjector().userVm, username: "")
}




struct ConnectionsButton: View {
  var label: String
  var onTap: () -> Void
  var count: String
  
  var body: some View {
    HStack {
      Button(action: onTap, label: {
        ZStack {
          RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
          Text(label + " : " + count)
            .rmNueueBold(28)
            .white()
            .padding(.vertical, 10)
        }
      })
      Spacer()
    }
  }
}

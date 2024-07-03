//
//  LoginView.swift
//  AbilashTask
//
//  Created by MacBk on 29/06/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var GooleSign = UserAuthModel()
    @StateObject var AppleLoginViewController = LoginViewController()
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .center){
                Text("Location Tracter")
                    .font(.title)
                    .bold()
            }
            Spacer()
            VStack(alignment: .leading,spacing: 15){
                
                Text("Login")
                    .font(.title)
                    .bold()
                
                Text("Please sign in to continue")
                    .font(.footnote)
                
                Button(action: {
                    GooleSign.signIn()
                }, label: {
                    
                    HStack{
                        Image("Google_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35)
                            .padding(2)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color.white)
                            )
                            .padding(5)
                        
                        Text("Sign in with Google")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        Spacer()

                    }
                    .frame(width: 230,height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.blue)
                    )
                })
                
                Button(action: {
                    AppleLoginViewController.handleAuthorizationAppleIDButtonPress()
                }, label: {
                    
                    HStack{
                        Image(systemName: "apple.logo")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 35)
                            .foregroundColor(Color.black)
                            .padding(2)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color.white)
                            )
                            .padding(5)
                        
                        Text("Sign in with Apple")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .frame(width: 230,height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.black)
                    )
                })
                
            }
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    LoginView()
}

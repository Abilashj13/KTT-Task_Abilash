//
//  GoogleLogin.swift
//  AbilashTask
//
//  Created by MacBk on 28/06/24.
//
import Foundation
import GoogleSignIn
class UserAuthModel: ObservableObject {
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            UserDefaults.standard.setValue(true, forKey: "isUserLogged")
            print(user.profile?.name ?? "")
            UserDefaults.standard.setValue(user.profile?.name ?? "", forKey: "UserName")
            UserDefaults.standard.setValue(user.userID ?? "", forKey: "UserID")
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
            self.checkStatus()
        }
    }
    
    func signIn(){
        if let window = UIApplication.shared.windows.first, let RVC = window.rootViewController{
            let config = GIDConfiguration(clientID: "544595035669-963fb5mjcmt6b9q2ecg9rb5urdds73rh.apps.googleusercontent.com")
            GIDSignIn.sharedInstance.configuration = config
            GIDSignIn.sharedInstance.signIn(withPresenting: RVC,completion: { user, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                }
                self.checkStatus()
            })

        }
        
//       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
//        let config = GIDConfiguration(clientID: "526836375834-v34jcfhcn5hjivbi2ffp12nbq8tfqhan.apps.googleusercontent.com")
//                
//        GIDSignIn.sharedInstance.configuration = config
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController,completion: { user, error in
//            if let error = error {
//                print("error: \(error.localizedDescription)")
//            }
//            self.checkStatus()
//        })
        
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
    }
    
}

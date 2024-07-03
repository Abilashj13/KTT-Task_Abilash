//
//  ContentView.swift
//  AbilashTask
//
//  Created by MacBk on 27/06/24.
//

import SwiftUI
import RealmSwift
import CoreLocation
struct ContentView: View {
    @StateObject var UserDetailsObj = UserDetails()
    let timer = Timer.publish(every: 900, on: .main, in: .common).autoconnect()
    @ObservedResults(UserLocation.self) var userLocation
    @ObservedObject var LocationManagerObj = LocationManager()
    var body: some View {
        ZStack{
            if LocationManagerObj.Authoriztaion == .authorizedAlways || LocationManagerObj.Authoriztaion == .authorizedWhenInUse{
                ZStack{
                    if UserDetailsObj.isUserLogged{
                        if userLocation.count > 0{
                            VStack{
                                HStack(alignment: .top){
                                    if let Name = UserDefaults.standard.string(forKey: "UserName"){
                                        Text("\(Name)")
                                            .font(.title)
                                            .bold()
                                    }else{
                                        Text("Name")
                                            .font(.title)
                                            .bold()

                                    }
                                    Spacer()
                                    Button(action: {
                                        
                                        UserDefaults.standard.setValue(false, forKey: "isUserLogged")
                                        UserDefaults.standard.setValue("", forKey: "UserName")
                                        UserDefaults.standard.setValue("", forKey: "UserID")

                                    }, label: {
                                        Text("Logout")
                                    })
                                }
                                .padding()

                                LocationListView(LocationObj: .constant(LocationManagerObj.location))
                                
                                Spacer()
                            }
                            .onAppear(perform: {
                                LocationManagerObj.GetLocation()
                            })
                            .onReceive(timer, perform: {
                                _ in
                                LocationManagerObj.GetLocation()
                            })
                           

                        }else{
                            Text("No location tracked yet")
                                .onAppear(perform: {
                                    LocationManagerObj.GetLocation()
                                })
                        }
                       
                    }else{
                        LoginView()
                    }
                }
                
            }else{
                VStack{
                    Text("Location access allows you to track your location")
                        .font(.title3)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                                                        
                        UIApplication.shared.open(URL(string: "App-prefs:Privacy&path=LOCATION/\(Bundle.main.bundleIdentifier!)")!)
                                                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Enable location access")
                                .font(.title3)
                            Spacer()
                        }
                        .padding(.vertical,10)
                        .foregroundColor(Color.white)
                        .background(Color.blue.cornerRadius(6))
                        
                    })
                    .padding(.horizontal)
                }

            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("location"))){
            item in
            if let Obj = item.object, let location = Obj as? CLLocation,let UserID = UserDefaults.standard.string(forKey: "UserID"){
                $userLocation.append(UserLocation(TimeStamp: Date().timeIntervalSinceNow, Lat: location.coordinate.latitude, long: location.coordinate.longitude, UserId: UserID))
            }
        }
    }
}

#Preview {
    ContentView()
}

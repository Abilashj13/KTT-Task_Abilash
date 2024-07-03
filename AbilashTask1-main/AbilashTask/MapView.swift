//
//  MapView.swift
//  BibleReadingZone
//
//  Created by Abilash  MacBook on 17/10/23.
//

import SwiftUI
import CoreLocation
import RealmSwift

struct MapViewNew: View {
    @State var Location : CLLocation
    @State var latitude : Double
    @State var longitude : Double
    @Binding var name : String
    @Environment(\.presentationMode) var PM
    var body: some View {
        ZStack(alignment: .bottom){
            SingleLocationView(requestLocation: .constant(CLLocationCoordinate2D(latitude: latitude, longitude: longitude)), requestLocation2: .constant(CLLocationCoordinate2D(latitude: Location.coordinate.latitude, longitude: Location.coordinate.longitude)),DestinationName:name).navigationBarHidden(true)
            VStack{
                
                HStack{
                    Button(action: {
                        PM.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color.blue)

                    })
                    Spacer()
                }
                .padding()
                Spacer()
                NavigationLink(destination: {
                    MapViewAll(Location: Location, name: .constant(""))
                }, label: {
                    HStack(alignment: .top){
                        Image(systemName: "globe")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                        VStack(alignment: .leading){
                            Text(name)
                                .bold()
                                .foregroundColor(Color.black)
                            Text("\(latitude), \(longitude)")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                        }
                        Spacer()
                    
                        Image(systemName: "play.fill")
                    }
                    .padding(5)
                    .background(Color.white.cornerRadius(10))
                    .padding(5)

                })

            }
        }
        .navigationBarHidden(true)
    }
}

struct MapViewAll: View {
    @State var Location : CLLocation
    @Binding var name : String
    @Environment(\.presentationMode) var PM
    @ObservedResults(UserLocation.self) var todo
    var body: some View {
        ZStack(alignment: .bottom){
            MultipleLocationView(LocationsArr: .constant(todo.filter({ UserLocation in
                if let UserID = UserDefaults.standard.string(forKey: "UserID"), UserID != "" , UserID == UserLocation.UserId{
                    return true
                }else{
                    return false
                }
            }).map({ UserLocation in
                St_Loaction(name: "", coordinate: CLLocationCoordinate2D(latitude: UserLocation.Lat, longitude: UserLocation.long))
            })), CurentLocation: Location)
            
            VStack{
                
                HStack{
                    Button(action: {
                        PM.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color.blue)

                    })
                    Spacer()
                }
                .padding()
                Spacer()
                
                HStack(alignment: .top){
                    VStack(alignment: .leading){
                        if let Name = UserDefaults.standard.string(forKey: "UserName"){
                            Text("\(Name)")
                                .font(.title)
                                .bold()
                        }
                    }
                    Spacer()
                }
                .padding(5)
                .background(Color.white.cornerRadius(10))
                .padding(5)

            }
        }
        .navigationBarHidden(true)
    }
}

//#Preview {
//    MapViewNew()
//}

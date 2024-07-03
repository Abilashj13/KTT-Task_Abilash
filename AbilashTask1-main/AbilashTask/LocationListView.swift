//
//  ContentView.swift
//  RealmTodo
//
//  Created by MacBk on 02/07/24.
//

import SwiftUI
import RealmSwift
import CoreLocation
struct LocationListView: View {
    @ObservedResults(UserLocation.self) var todo
    @Binding var LocationObj : CLLocation?
    var body: some View {
        if let Location = LocationObj{
            VStack{
                List{
                    ForEach(todo,id: \.id){
                        item in
                        if let UserID = UserDefaults.standard.string(forKey: "UserID"), UserID != "" , UserID == item.UserId{
                            
                            LocationRowView(Location: Location, latitude: item.Lat, longitude: item.long,CDate:item.TimeStamp)
                            
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                Spacer()
            }
            .navigationTitle("Location Details")
        }
    }
}

#Preview {
    LocationListView(LocationObj: .constant(nil))
}

struct LocationRowView : View {
    let Location: CLLocation
    var latitude:Double
    var longitude:Double
    var CDate : Double
    @State var CurrentAddress = " "
    
    func GetCityNAme(latitude:Double,longitude:Double,name : @escaping ([String]) -> Void ){
        var arr : [String] = []
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemarks = placemarks ,let placemark = placemarks.first{
                if let subLocality = placemark.subLocality{
                    arr.append(subLocality)
                }
                if let locality = placemark.locality{
                    arr.append(locality)
                }
                
            }
            name(arr)
        }
        
    }

    var body: some View {
        NavigationLink(destination: {
            MapViewNew(Location: Location, latitude: latitude, longitude: longitude, name: $CurrentAddress)
        }, label: {
            VStack(alignment: .leading){
                Text(CurrentAddress)
                Text("\(latitude), \(longitude)")
                    .fontWeight(.semibold)
                  Text(Date.now.addingTimeInterval(CDate), style: .date) + Text(" ") + Text(Date.now.addingTimeInterval(CDate), style: .time)
            }
            .onAppear(perform: {
                GetCityNAme(latitude: latitude, longitude: longitude) { str in
                    CurrentAddress = str.joined(separator: ",")
                }
            })
        })
    }
}

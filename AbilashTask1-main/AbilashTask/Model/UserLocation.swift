//
//  Todo.swift
//  RealmTodo
//
//  Created by MacBk on 02/07/24.
//

import Foundation
import RealmSwift

class UserLocation : Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id : ObjectId

    @Persisted var completed : Bool = false
    
    @Persisted var TimeStamp : Double
    @Persisted var Lat : Double
    @Persisted var long : Double
    @Persisted var UserId : String = ""
    
    convenience init(TimeStamp:Double,Lat:Double,long:Double,UserId:String) {
        self.init()
        self.TimeStamp = TimeStamp
        self.Lat = Lat
        self.long = long
        self.UserId = UserId
    }

}

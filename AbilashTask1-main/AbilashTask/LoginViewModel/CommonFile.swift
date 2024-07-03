//
//  CommonFile.swift
//  AbilashTask
//
//  Created by MacBk on 29/06/24.
//

import Foundation
import SwiftUI
class UserDetails: ObservableObject {
    
    @AppStorage("isUserLogged") var isUserLogged = false{
        didSet {
            self.objectWillChange.send()
        }
    }
    
    @AppStorage("UserName") var UserName = ""{
        didSet {
            self.objectWillChange.send()
        }
    }
    
    @AppStorage("UserID") var UserID = ""{
        didSet {
            self.objectWillChange.send()
        }
    }
    
}

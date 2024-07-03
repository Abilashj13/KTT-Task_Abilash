//
//  AppDelegate.swift
//  AbilashTask
//
//  Created by MacBk on 01/07/24.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var LocationManagerObj = LocationManager()
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        LocationManagerObj.Req()
        return true
    }
}

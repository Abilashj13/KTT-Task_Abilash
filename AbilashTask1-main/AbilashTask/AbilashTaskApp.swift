//
//  AbilashTaskApp.swift
//  AbilashTask
//
//  Created by MacBk on 27/06/24.
//

import SwiftUI

@main
struct AbilashTaskApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
        }
    }
}

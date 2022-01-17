//
//  MessengerAppApp.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI


@main
struct MessengerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ConversationListView()
                .environmentObject(AppStateModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        

        return true
    }
}

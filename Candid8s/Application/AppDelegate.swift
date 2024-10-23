//
//  AppDelegate.swift
//  Candid8s
//
//  Created by Martin Ausilio
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseCore
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Firebase.Analytics.setAnalyticsCollectionEnabled(true)
        return true
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

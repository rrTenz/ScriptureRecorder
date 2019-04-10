//
//  AppDelegate.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 5/24/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit
//import GoogleMobileAds
//import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            // Override point for customization after application launch.
            
            //TODO add of ads
            //GADMobileAds.configure(withApplicationID: "ca-app-pub-4236615842105265~6847562074")
            
            return true
        }
        
        //TODO add of Cloud
        //FirebaseApp.configure()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        while bookmarks.count < Const.BOOKMARK_COUNT {
            bookmarks.append(Scripture.Bookmark())
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    let VERSION: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
    
    var didLoadDefaults = false

    var bookEnum = Const.Book.BOM
    var bookString = Const.BOM
    var subBookString = Const.BOM_1NE    
    var bookString_prev = ""
    var subBookString_prev = ""
    var chapter = 1
    var verse = 1
    
    var userName = "Default"
    var userName_prev = "Default"
    var userArray: [String] = ["Default"]
    
    var languageURL_array: [String] = ["?lang=eng", "?lang=spa", "?lang=por"]
    var languageURL = "?lang=eng"
    
    var continualPlay = true
    var continualRecord = false
    
    var shareFile = false
    var whatToShare: Const.WhatToShare = Const.WhatToShare.Book
    var mergeAudioURL = NSURL()
    
    var bookmarks = Array<Scripture.Bookmark>()
    var goToBookmark = false
    
    enum Language: Int {
        case English = 0
        case Spanish = 1
        case Portuguese = 2
    }
    
    var Language: Language = .English
}


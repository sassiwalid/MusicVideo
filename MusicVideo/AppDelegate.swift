//
//  AppDelegate.swift
//  MusicVideo
//
//  Created by Walid Sassi on 13/11/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import UIKit
var reachability : Reachability?
var reachabilityStatus = " "
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var InternetCheck: Reachability?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"checkForReachability:", name: kReachabilityChangedNotification, object: nil);
        InternetCheck = Reachability.reachabilityForInternetConnection()
        InternetCheck?.startNotifier()
        return true
    }
    func reachabilityChanged(notification:NSNotification)
    {
        reachability = notification.object as? Reachability
        statusChangedWithReachability(reachability!)
    }
    func statusChangedWithReachability (CurrentReachabilityStatus: Reachability)
    {

        let networkStatus: NetworkStatus = CurrentReachabilityStatus.currentReachabilityStatus()
        switch networkStatus.rawValue{
        case NotReachable.rawValue : reachabilityStatus = NOACCESS
        print(reachabilityStatus)
        case ReachableViaWiFi.rawValue: reachabilityStatus = WIFI
        print(reachabilityStatus)
        case ReachableViaWWAN.rawValue: reachabilityStatus = WWAN
        print(reachabilityStatus)
        default: return
        }
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged", object: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil)
    }


}


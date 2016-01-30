//
//  AppDelegate.swift
//  BlockerFinal
//
//  Created by GBS-ios on 12/1/15.
//  Copyright © 2015 globussoft. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.statusBarHidden = true
        
        
        
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(30)
        Parse.setApplicationId("FzqFh45TPxnjH6R2XEQ6o8CpiiAJkjox3U29HTR5", clientKey: "4N3HEHKtWcgLKmkUPHSNv2buo6i2I3FY1NQNOln9")
        
        
        let userNotificationTypes: UIUserNotificationType = [.Alert, .Badge, .Sound]
        
        let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()

        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
      let check = defaults.objectForKey("pushNotificationData")
        
        if check != nil
        {
          print(check)
        }
        
        
        
        return true
    }

    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
       
    }
    func application(application: UIApplication,  didReceiveRemoteNotification userInfo: [NSObject : AnyObject],  fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(userInfo, forKey: "pushNotification")
        defaults.synchronize()
        self .fetchFromParse()
        if application.applicationState == .Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
        completionHandler(.NewData)
    }
 
    func fetchFromParse()
    {
        
        let query = PFQuery(className:"BlockerList")
        
        query.limit=1000
        // Array for object ids
        do
        {
            let varTemp =  try query.findObjects()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(varTemp, forKey: "pushNotificationData")
        }
        catch
        {
            
        }
        
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Store the deviceToken in the current Installation and save it to Parse
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  AppDelegate.swift
//  Picsloot
//
//  Created by think360 on 13/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {

    var window: UIWindow?
    var appInstance : AppDelegate!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        appInstance = self
        
        GIDSignIn.sharedInstance().delegate = self
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "6thimage")
        
        
      
        
       return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
       
        return handled
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        FBSDKApplicationDelegate.sharedInstance().application(app,
                                                              open: url,
                                                              sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!,
                                                              annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        func application(application: UIApplication,
                         openURL url: NSURL,
                         sourceApplication: String?,
                         annotation: AnyObject?) -> Bool
        {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                         open: url as URL!,
                                                                         sourceApplication: sourceApplication,
                                                                         annotation: annotation)
        }
       return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])

        
//        
//        if !url.absoluteString.contains("160743847789712")
//        {
//            func application(application: UIApplication,
//                             openURL url: NSURL,
//                             sourceApplication: String?,
//                             annotation: AnyObject?) -> Bool {
//                return FBSDKApplicationDelegate.sharedInstance().application(application,
//                                                                             open: url as URL!,
//                                                                             sourceApplication: sourceApplication,
//                                                                             annotation: annotation)
//            }
//
//            return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//            
//        }else
//        {
//            func application(application: UIApplication,
//                             openURL url: NSURL,
//                             sourceApplication: String?,
//                             annotation: AnyObject?) -> Bool {
//                return FBSDKApplicationDelegate.sharedInstance().application(application,
//                                                                             open: url as URL!,
//                                                                             sourceApplication: sourceApplication,
//                                                                             annotation: annotation)
//            }
//            
//            
//            return true
//        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user:GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
         FBSDKAppEvents.activateApp()
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
        
         FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


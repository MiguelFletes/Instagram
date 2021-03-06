//
//  AppDelegate.swift
//  instagram
//
//  Created by Michael Fletes on 2/22/18.
//  Copyright © 2018 Michael Fletes. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instagram"
                configuration.clientKey = "vvferqwesdqewrgtrhyntbbrwd"  // set to nil assuming you have not set clientKey
                configuration.server = "https://enigmatic-mountain-25267.herokuapp.com/parse"
            })
        )
        NotificationCenter.default.addObserver(forName: Notification.Name("didLogout"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Logout notification received")
            // TODO: Logout the User
            // TODO: Load and show the login view controller
            self.logOut()
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("didCancel"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Cancel notification received")
            self.goBack()
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("didShare"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Share notification received")
            self.goBack()
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("upload"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Upload notification received")
            self.upload()
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("didBack"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Back notification received")
            self.goBack()
        }
        if PFUser.current() != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // view controller currently being set in Storyboard as default will be overridden
            let loggedInViewController = storyboard.instantiateViewController(withIdentifier: "tabBar")
            self.window?.rootViewController = loggedInViewController
        }
        return true
    }
    
    func logOut() {
        // Logout the current user
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "login")//PUT_YOUR_LOGIN_VC_ID_HERE
                self.window?.rootViewController = loginViewController
            }
        })
    }
    
    func goBack() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "tabBar")
        self.window?.rootViewController = loginViewController
    }
    
    func upload() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "UploadNavContoller")
        self.window?.rootViewController = loginViewController
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
    


}


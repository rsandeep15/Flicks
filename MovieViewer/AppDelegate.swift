//
//  AppDelegate.swift
//  MovieViewer
//
//  Created by Sandeep Raghunandhan on 1/31/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nowPlayingNavController = storyboard.instantiateViewController(withIdentifier: "MoviesNavigationController") as! UINavigationController
        let nowPlayingVC = nowPlayingNavController.topViewController as! MoviesViewController
        nowPlayingVC.navigationItem.title = "Now Playing"
        nowPlayingVC.endpoint = "now_playing"
        
        // Customizing the navigation controller
        nowPlayingNavController.tabBarItem.title = "Now Playing"
        nowPlayingNavController.tabBarItem.image = UIImage(named: "now-playing")
        nowPlayingNavController.tabBarItem.badgeColor = UIColor.gray
        
        let topRatedNavController = storyboard.instantiateViewController(withIdentifier: "MoviesNavigationController") as! UINavigationController
        
        let topRatedVC = topRatedNavController.topViewController as! MoviesViewController
        topRatedVC.navigationItem.title = "Top Rated"
        topRatedVC.endpoint = "top_rated"
        
        topRatedNavController.tabBarItem.title = "Top Rated"
        topRatedNavController.tabBarItem.badgeColor = UIColor.blue
        topRatedNavController.tabBarItem.image = UIImage(named: "top-rated")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavController, topRatedNavController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
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


}


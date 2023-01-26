//
//  AppDelegate.swift
//  RodoSampleApp
//
//  Created by Daniel Perez on 1/25/23.
//

import UIKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Model Data
    var carInventoryListModel:InventoryListModel<CarItem> = InventoryListModel<CarItem>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        window = UIWindow(frame: UIScreen.main.bounds)
        let contentViewController = ContentViewController()
        window?.rootViewController = contentViewController
        window?.makeKeyAndVisible()
        
        
        // Load the sample JSON Data into the model
        do{
            try carInventoryListModel.inventoryItems = loadObjectFromBundle("Exercise_Dataset.json")
        } catch{
            //fatalError("Could not Load Object From Bundle")
            print("Could not load JSON Data from Bundle")
        }

        return true
        
    }

    // UISceneSession Lifecycle is only available for ios 13+
    // which means we still need to use the following:
    
    func applicationWillResignActive(_ application: UIApplication ){
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
   


}


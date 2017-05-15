//
//  AppDelegate.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 21..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func getToken() {
        
        //let userInfo = ["username":"inhye.yu@bankwareglobal.com", "password": "efb0d283f0b2518c1547b21041f1a31c30050576fe6bfb1530f3a62670035727"]
        let userInfo = ["username":"inhye.yu@bankwareglobal.com", "password": "d0523780d96fdcc8726ebf7852af1d730e5629ae456088c1970733739391c98d"]
        let loginRequest: DataRequest = Alamofire.request("https://stage-api.moimdomo.com/sessions", method: .post, parameters: userInfo, encoding: JSONEncoding.default)
        
        let requestComplete: (HTTPURLResponse?, Result<String>) -> Void = { response, result in
            if let body = result.value {
                UserDefaults.standard.set(body, forKey: "token")
                NotificationCenter.default.post(name: tokenReadyNotification, object: self)
                print("token ========================")
                print(body)
                print("token ========================/")
            }
        }
        
        loginRequest.responseString { response in
            requestComplete(response.response, response.result)
        }
    }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // TabBarItem Text Color
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.gray], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : Constant.ColorConst.mainColor], for: UIControlState.selected)
        
        // TabBarItem Image Color
        UITabBar.appearance().tintColor = Constant.ColorConst.mainColor

        
        UserDefaults.standard.set(nil, forKey: "token")
        getToken()
        
        
        do {
            Network.reachability = try Reachability(hostname: "www.google.com")
            do {
                try Network.reachability?.start()
            } catch let error as Network.Error {
                print(error)
            } catch {
                print(error)
            }
        } catch {
            print(error)
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


}


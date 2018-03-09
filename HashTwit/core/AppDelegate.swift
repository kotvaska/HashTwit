//
//  AppDelegate.swift
//  HashTwit
//
//  Created by Anastasia Zolotykh on 08.03.2018.
//  Copyright © 2018 kotvaska. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appConfiguration: AppConfiguration = AppConfiguration()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

//        window = UIWindow(frame: UIScreen.main.bounds)
        appConfiguration.showController(from: window!)

        return true
    }

}


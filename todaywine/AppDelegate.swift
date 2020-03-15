//
//  AppDelegate.swift
//  todaywine
//
//  Created by jimmy on 2020/02/20.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if TEST
        if #available(iOS 13, *) {
            print("set in SceneDelegate")
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            // 1st tab - main
            let mainVC = mainStoryboard.instantiateViewController(withIdentifier:  "TodayWineViewController")
            let mainItem = UITabBarItem()
            mainItem.title = "Home"
            mainItem.image = UIImage(named: "home_icon")
            mainVC.tabBarItem = mainItem
            
            // 2rd tab - 퀴즈
//            let quizVC = QuizViewController()
            let quizVC = mainStoryboard.instantiateViewController(withIdentifier:  "QuizViewController2")
            let quizItem = UITabBarItem()
            quizItem.title = "Quiz"
            quizVC.tabBarItem = quizItem

            // 3rd tab - 검색
            let searchVC = mainStoryboard.instantiateViewController(withIdentifier:  "SearchViewController")
            let searchItem = UITabBarItem()
            searchItem.title = "search"
            searchItem.image = UIImage()
            searchVC.tabBarItem = searchItem
            let searchNVC = UINavigationController(rootViewController: searchVC)
            
            // 4th tab
            let mypageVC = MypageViewController()
            let mypageItem = UITabBarItem()
            mypageItem.title = "mypage"
            mypageItem.image = UIImage(named: "home_icon")
            mypageVC.tabBarItem = mypageItem
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [mainVC, quizVC, searchNVC, mypageVC]
            
            tabBarController.selectedViewController = mainVC
            
            window.rootViewController = tabBarController
        }
        #endif
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


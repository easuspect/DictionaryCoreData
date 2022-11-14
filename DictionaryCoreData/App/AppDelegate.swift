//
//  AppDelegate.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/7/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startApplication()
        return true
    }
    
    private func startApplication() {
        let database = CoreDataManager.init(modelName: "DictionaryDataBase")
        let WordListViewController = WordListViewController(database: database)
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: WordListViewController)
        window?.makeKeyAndVisible()
    }
}


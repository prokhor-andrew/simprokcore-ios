//
//  AppDelegate.swift
//  sample
//
//  Created by Andrey Prokhorenko on 19.02.2022.
//

import simprokcore
import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
        
        start()
        
        return true
    }
}


extension AppDelegate: Core {
    typealias State = AppState
    
    var layers: [Layer<AppState>] {[
        ~UILayer(),
        Layer(StorageLayer()),
        LoggerLayer().layer
    ]}
}

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
    typealias Event = AppEvent
    
    var layers: [Layer<AppEvent>] {[
        ~UILayer(),
         LoggerLayer().layer,
         Layer.layer(StorageLayer()),
    ]}
    

    var domain: State<AppEvent> {
        StateBuilder()
            .when {
                if case .storage = $0 {
                    return true
                } else {
                    return false
                }
            }
            .while(is: .click)
            .final()
    }
}

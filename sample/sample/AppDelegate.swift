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
    typealias State = AppState
    
    var layers: [Layer<AppState, AppEvent>] {[
        ~UILayer(),
         Layer.layer(StorageLayer()),
        LoggerLayer().layer()
    ]}
    
    func reduce(state: AppState?, event: AppEvent) -> ReducerResult<AppState> {
        switch event {
        case .click:
            if let state = state {
                return .set(.init(state.value + 1))
            } else {
                return .skip
            }
        case .storage(let value):
            return .set(.init(value))
        }
    }
}

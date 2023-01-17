//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokstate

public protocol Core: AnyObject {
    associatedtype AppEvent
    associatedtype AppFeature: CoreFeature where AppFeature.ExternalTrigger == AppEvent, AppFeature.ExternalEffect == AppEvent
    
    var modules: Modules<AppEvent> { get }
    
    var feature: AppFeature { get }
}

public extension Core {
    
    func start() {
        _start(sender: self, feature: feature, modules: modules)
    }
    
    func stop() {
        _stop(self)
    }
}


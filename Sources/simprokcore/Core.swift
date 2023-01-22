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
    
    var sources: Sources<AppEvent> { get }
    
    var feature: CoreFeature<AppEvent> { get }
}

public extension Core {
    
    func start() {
        _start(sender: self, feature: feature, sources: sources)
    }
    
    func stop() {
        _stop(self)
    }
}

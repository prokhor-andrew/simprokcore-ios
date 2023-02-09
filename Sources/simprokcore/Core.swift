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
    
    var story: Story<AppEvent> { get }
}

public extension Core {
    
    func start() {
        _start(sender: self, story: story, sources: sources)
    }
    
    func stop() {
        _stop(self)
    }
}

//
//  Final.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import Foundation


public func final<Event>() -> State<Event> {
    State.final()
}

public extension State {
    
    static func final() -> State<Event> {
        State { _ in .skip }
    }
}

public extension StateBuilder {
 
    func final() -> State<Event> {
        link(to: State.final())
    }
}

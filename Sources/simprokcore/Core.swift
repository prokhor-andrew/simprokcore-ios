//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A `RootMachine` protocol that describes all the layers of the application.
public protocol Core: RootMachine where Input == Event, Output == Event {
    associatedtype Event
    
    var layers: [Layer<Event>] { get }
    
    var feature: State<Event> { get }
}

public extension Core {
    
    var child: Machine<Event, Event> {
        Machine.merge(layers.map { $0.machine }).controller(.set(feature, outputs: [])) { state, event in
            switch event {
            case .ext(let value), .int(let value):
                switch state.transit(value) {
                case .skip:
                    return .set(state, outputs: [])
                case .set(let new):
                    return .set(new, outputs: .ext(value), .int(value))
                }
            }
        }
    }
}

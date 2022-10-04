//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simprokcontroller


/// A `RootMachine` protocol that describes all the layers of the application.
public protocol Core: RootMachine where Input == Event, Output == Event {
    associatedtype Event
    
    var layers: [Layer<Event>] { get }
    
    var feature: State<Event> { get }
}

public extension Core {
    
    var child: Machine<Event, Event> {
        Machine.merge(layers.map { $0.machine }).controller(feature) { event in
            [
                .ext(event),
                .int(event)
            ]
        }
    }
}

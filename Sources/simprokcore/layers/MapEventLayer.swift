//
//  MapEventLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol MapEventLayer {
    associatedtype GlobalState
    associatedtype GlobalEvent
    associatedtype Event
    
    /// A machine that receives mapped state as input and emits output that is reduced into application's state.
    var machine: Machine<GlobalState, Event> { get }
    
    /// A mapper that maps layer's event into application's event and sends it into the global reducer
    func map(event: Event) -> GlobalEvent
}

public extension MapEventLayer {
    
    /// An equivalent to Layer(self)
    var layer: Layer<GlobalEvent, GlobalState> {
        Layer(self)
    }
}


public extension MapEventLayer {
    
    /// An equivalent to Layer(self)
    prefix static func ~(operand: Self) -> Layer<GlobalEvent, GlobalState> {
        operand.layer
    }
}

//
//  ProducerLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general protocol that describes a type that represents a layer object that does not consume state.
/// Contains a machine that *does not* receive mapped layer state as input and emits output that is reduced into application's state.
public protocol ProducerLayer {
    associatedtype GlobalEvent
    associatedtype GlobalState
    associatedtype Event
    associatedtype State
    
    /// A machine that *does not* receive mapped state as input and emits output that is reduced into application's state.
    var machine: Machine<State, Event> { get }
    
    /// A mapper that maps layer's event into application's event and sends it into the global reducer
    func map(event: Event) -> GlobalEvent
}


public extension ProducerLayer {
    
    /// An equivalent to Layer(self)
    var layer: Layer<GlobalEvent, GlobalState> {
        Layer(self)
    }
}


public extension ProducerLayer {
    
    /// An equivalent to Layer(self)
    prefix static func ~(operand: Self) -> Layer<GlobalEvent, GlobalState> {
        operand.layer
    }
}

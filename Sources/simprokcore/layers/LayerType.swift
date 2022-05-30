//
//  LayerType.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general protocol that describes a type that represents a layer object.
/// Contains a machine that receives mapped layer state as input and emits output that is reduced into application's state.
public protocol LayerType {
    associatedtype GlobalState
    associatedtype GlobalEvent
    associatedtype State
    associatedtype Event
    
    /// A machine that receives mapped state as input and emits output that is reduced into application's state.
    var machine: Machine<State, Event> { get }

    /// A mapper that maps application's state into layer state and sends it into machine as input.
    func map(state: GlobalState) -> State
    
    /// A mapper that maps layer's event into application's event and sends it into the global reducer
    func map(event: Event) -> GlobalEvent
}

public extension LayerType {
    
    /// An equivalent to Layer(self)
    var layer: Layer<GlobalEvent, GlobalState> {
        Layer(self)
    }
}


public extension LayerType {
    
    /// An equivalent to Layer(self)
    prefix static func ~(operand: Self) -> Layer<GlobalEvent, GlobalState> {
        operand.layer
    }
}

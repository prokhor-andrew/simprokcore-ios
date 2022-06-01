//
//  MapStateLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general protocol that describes a type that represents a layer object.
/// Contains a machine that receives layer state as input and emits global events as output.
public protocol MapStateLayer {
    associatedtype GlobalEvent
    associatedtype GlobalState
    associatedtype State
    
    /// A machine that receives mapped state as input and emits output.
    var machine: Machine<State, GlobalEvent> { get }

    /// A mapper that maps application's state into layer state and sends it into machine as input.
    func map(state: GlobalState) -> State
}


public extension MapStateLayer {
    
    /// An equivalent to Layer.state(self)
    var layer: Layer<GlobalState, GlobalEvent> {
        Layer.state(self)
    }
}


public extension MapStateLayer {
    
    /// An equivalent to Layer.state(self)
    prefix static func ~(operand: Self) -> Layer<GlobalState, GlobalEvent> {
        operand.layer
    }
}

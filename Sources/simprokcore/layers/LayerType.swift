//
//  LayerType.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general protocol that describes a type that represents a layer object.
/// Contains a machine that receives mapped layer state as input and emits output.
public protocol LayerType {
    associatedtype Event
    associatedtype Input
    associatedtype Output
    
    /// A machine that receives mapped state as input and emits output that.
    var machine: Machine<Input, Output> { get }

    /// A mapper that maps application's state into layer state and sends it into machine as input.
    func map(event: Event) -> Input
    
    /// A mapper that maps layer's event into application's event and sends it into the global reducer
    func map(output: Output) -> Event
}

public extension LayerType {
    
    /// An equivalent to Layer.layer(self)
    var layer: Layer<Event> {
        Layer.layer(self)
    }
}


public extension LayerType {
    
    /// An equivalent to Layer.layer(self)
    prefix static func ~(operand: Self) -> Layer<Event> {
        operand.layer
    }
}

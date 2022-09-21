//
//  ProducerLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simproktools


/// A general protocol that describes a type that represents a layer object that does not consume state.
/// Contains a machine that *does not* receive mapped layer state as input and emits output.
public protocol ProducerLayer {
    associatedtype Event
    associatedtype Input
    associatedtype Output
    
    /// A machine that *does not* receive mapped state as input and emits output.
    var machine: Machine<Input, Output> { get }
    
    /// A mapper that maps layer's event into application's event and sends it into the global reducer
    func map(output: Output) -> Ward<Event>
}


public extension ProducerLayer {
    
    /// An equivalent to Layer.producer(self)
    var layer: Layer<Event> {
        Layer.producer(self)
    }
}


public extension ProducerLayer {
    
    /// An equivalent to Layer.producer(self)
    prefix static func ~(operand: Self) -> Layer<Event> {
        operand.layer
    }
}

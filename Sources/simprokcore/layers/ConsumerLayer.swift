//
//  ConsumerLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simproktools


/// A general protocol that describes a type that represents a layer object that does not produce events.
/// Contains a machine that receives mapped layer state as input and *does not* emit output.
public protocol ConsumerLayer {
    associatedtype Event
    associatedtype Input
    associatedtype Output
    
    /// A machine that receives mapped state as input and *does not* emit output.
    var machine: Machine<Input, Output> { get }
    
    /// A mapper that maps application's state into layer state and sends it into machine as input.
    func map(input: Event) -> Ward<Input>
}


public extension ConsumerLayer {
    
    /// An equivalent to Layer.consumer(self)
    var layer: Layer<Event> {
        Layer.consumer(self)
    }
}


public extension ConsumerLayer {
    
    /// An equivalent to Layer.consumer(self)
    prefix static func ~(operand: Self) -> Layer<Event> {
        operand.layer
    }
}

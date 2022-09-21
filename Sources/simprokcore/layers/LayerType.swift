//
//  LayerType.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simproktools



public protocol LayerType {
    associatedtype Event
    associatedtype Input
    associatedtype Output
    
    
    var machine: Machine<Input, Output> { get }

    
    func map(input: Event) -> Ward<Input>
    
    
    func map(output: Output) -> Ward<Event>
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

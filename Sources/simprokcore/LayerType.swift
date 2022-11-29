//
//  LayerType.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol LayerType {
    associatedtype Event
    
    var machine: Machine<Event, Event> { get }
}

public extension LayerType {
    
    /// An equivalent to Layer.layer(self)
    var layer: Layer<Event> {
        Layer(self)
    }
}


public extension LayerType {
    
    /// An equivalent to Layer.layer(self)
    prefix static func ~(operand: Self) -> Layer<Event> {
        operand.layer
    }
}


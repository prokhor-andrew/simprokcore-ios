//
//  NoMapLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

/// A general protocol that describes a type that represents a layer object.
/// Contains a machine that receives global state as input and emits global events as output.
public protocol NoMapLayer {
    associatedtype Event
    
    /// A machine that receives state as input and emits output 
    var machine: Machine<Event, Event> { get }
}


public extension NoMapLayer {
    
    /// An equivalent to Layer.nomap(self)
    var layer: Layer<Event> {
        Layer.nomap(self)
    }
}


public extension NoMapLayer {
    
    /// An equivalent to Layer.nomap(self)
    prefix static func ~(operand: Self) -> Layer<Event> {
        operand.layer
    }
}

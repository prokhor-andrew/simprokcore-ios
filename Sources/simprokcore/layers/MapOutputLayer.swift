//
//  MapOutputLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simproktools


/// A general protocol that describes a type that represents a layer object.
/// Contains a machine that receives global state as input and emits output.
public protocol MapOutputLayer {
    associatedtype Event
    associatedtype Output
    
    /// A machine that receives mapped state as input and emits output.
    var machine: Machine<Event, Output> { get }
    
    /// A mapper that maps layer's event into application's event and sends it into the global reducer
    func map(output: Output) -> Ward<Event>
}

public extension MapOutputLayer {
    
    /// An equivalent to Layer.output(self)
    var layer: Layer<Event> {
        Layer.output(self)
    }
}


public extension MapOutputLayer {
    
    /// An equivalent to Layer.output(self)
    prefix static func ~(operand: Self) -> Layer<Event> {
        operand.layer
    }
}

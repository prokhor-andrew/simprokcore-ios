//
//  MapInputLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general protocol that describes a type that represents a layer object.
/// Contains a machine that receives layer state as input and emits global events as output.
public protocol MapInputLayer {
    associatedtype Event
    associatedtype Input
    
    /// A machine that receives mapped state as input and emits output.
    var machine: Machine<Input, Event> { get }

    /// A mapper that maps application's state into layer state and sends it into machine as input.
    func map(event: Event) -> Input
}


public extension MapInputLayer {
    
    /// An equivalent to Layer.input(self)
    var layer: Layer<Event> {
        Layer.input(self)
    }
}


public extension MapInputLayer {
    
    /// An equivalent to Layer.input(self)
    prefix static func ~(operand: Self) -> Layer<Event> {
        operand.layer
    }
}

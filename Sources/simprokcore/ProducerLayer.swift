//
//  ProducerLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general protocol that describes a type that represents a layer object that does not consume state.
/// Contains a machine that *does not* receive mapped layer state as input and emits output that is reduced into application's state.
public protocol ProducerLayer {
    associatedtype GlobalState
    associatedtype Event
    associatedtype Input
    
    /// A machine that *does not* receive mapped state as input and emits output that is reduced into application's state.
    var machine: Machine<Input, Event> { get }
    
    /// A reducer that receives machine's event as output and reduces it into application's state.
    func reduce(state: GlobalState?, event: Event) -> ReducerResult<GlobalState>
}


public extension ProducerLayer {
    
    /// An equivalent to Layer(self)
    var layer: Layer<GlobalState> {
        Layer(self)
    }
}


public extension ProducerLayer {
    
    /// An equivalent to Layer(self)
    prefix static func ~(operand: Self) -> Layer<GlobalState> {
        operand.layer
    }
}

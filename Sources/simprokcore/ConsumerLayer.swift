//
//  ConsumerLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general protocol that describes a type that represents a layer object that does not produce events.
/// Contains a machine that receives mapped layer state as input and *does not* emit output that is reduced into application's state.
public protocol ConsumerLayer {
    associatedtype GlobalState
    associatedtype State
    associatedtype Output
    
    /// A machine that receives mapped state as input and *does not* emit output that is reduced into application's state.
    var machine: Machine<State, Output> { get }
    
    /// A mapper that maps application's state into layer state and sends it into machine as input.
    func map(state: GlobalState) -> State
}


public extension ConsumerLayer {
    
    /// An equivalent to Layer(self)
    var layer: Layer<GlobalState> {
        Layer(self)
    }
}


public extension ConsumerLayer {
    
    /// An equivalent to Layer(self)
    prefix static func ~(operand: Self) -> Layer<GlobalState> {
        operand.layer
    }
}

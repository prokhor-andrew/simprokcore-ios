//
//  ConsumerLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general protocol that describes a type that represents a layer object that does not produce events.
/// Contains a machine that receives mapped layer state as input and *does not* emit output.
public protocol ConsumerLayer {
    associatedtype GlobalState
    associatedtype Event
    associatedtype State
    
    /// A machine that receives mapped state as input and *does not* emit output.
    var machine: Machine<State, Event> { get }
    
    /// A mapper that maps application's state into layer state and sends it into machine as input.
    func map(state: GlobalState) -> State
}


public extension ConsumerLayer {
    
    /// An equivalent to Layer.consumer(self)
    func layer<GlobalEvent>() -> Layer<GlobalEvent, GlobalState> {
        Layer.consumer(self)
    }
}


public extension ConsumerLayer {
    
    /// An equivalent to Layer.consumer(self)
    prefix static func ~<GlobalEvent>(operand: Self) -> Layer<GlobalEvent, GlobalState> {
        operand.layer()
    }
}

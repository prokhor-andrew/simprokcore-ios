//
//  MapStateLayer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol MapStateLayer {
    associatedtype GlobalEvent
    associatedtype GlobalState
    associatedtype State
    
    /// A machine that receives mapped state as input and emits output that is reduced into application's state.
    var machine: Machine<State, GlobalEvent> { get }

    /// A mapper that maps application's state into layer state and sends it into machine as input.
    func map(state: GlobalState) -> State
}


public extension MapStateLayer {
    
    /// An equivalent to Layer(self)
    var layer: Layer<GlobalEvent, GlobalState> {
        Layer(self)
    }
}


public extension MapStateLayer {
    
    /// An equivalent to Layer(self)
    prefix static func ~(operand: Self) -> Layer<GlobalEvent, GlobalState> {
        operand.layer
    }
}

//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A `RootMachine` protocol that describes all the layers of the application.
public protocol Core: RootMachine
where Output == StateAction<State>, Input == StateAction<State> {
    associatedtype State
    
    /// Application's layers that receive the latest state and handle it via their mappers as well as emit events that are handled by their reducers.
    var layers: [Layer<State>] { get }
}

public extension Core {
    
    var child: Machine<StateAction<State>, StateAction<State>> {
        
        let reducer = CoreReducerMachine<Mapper<State?, ReducerResult<State>>, State> { $1($0) }
        
        let mapped: Machine<StateAction<State>, StateAction<State>> = reducer.outward { .set(.stateDidUpdate($0)) }.inward {
            switch $0 {
            case .stateDidUpdate:
                return .set()
            case .stateWillUpdate(let mapper):
                return .set(mapper)
            }
        }
        
        return Machine.merge(
            layers.reduce([]) { cur, layer in
                if cur.contains(where: { $0 === layer.machine }) {
                    return cur
                } else {
                    return cur.copy(add: layer.machine)
                }
            }.copy(add: mapped)
        ).redirect { .back($0) }
    }
}

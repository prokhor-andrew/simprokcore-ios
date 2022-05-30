//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A `RootMachine` protocol that describes all the layers of the application.
public protocol Core: RootMachine
where Output == StateAction<Event, State>, Input == StateAction<Event, State> {
    associatedtype Event
    associatedtype State
    
    /// Application's layers that receive the latest state and handle it via their mappers as well as emit events that are handled by their reducers.
    var layers: [Layer<Event, State>] { get }
    
    /// Application's reducer that receives event from layers and changes global state that is sent to the layers back
    func reduce(state: State?, event: Event) -> ReducerResult<State>
}

public extension Core {
    
    var child: Machine<StateAction<Event, State>, StateAction<Event, State>> {
        
        let reducer = CoreReducerMachine<Event, State> { reduce(state: $0, event: $1) }
        
        
        let mapped: Machine<StateAction<Event, State>, StateAction<Event, State>> = reducer.outward { .set(.stateDidUpdate($0)) }.inward {
            switch $0 {
            case .stateDidUpdate:
                return .set()
            case .stateWillUpdate(let event):
                return .set(event)
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

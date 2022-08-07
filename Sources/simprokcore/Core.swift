//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A `RootMachine` protocol that describes all the layers of the application.
public protocol Core: RootMachine where Input == Event, Output == Event {
    associatedtype Event
    
    var layers: [Layer<Event>] { get }
    
    
    var domain: State<Event> { get }
}

public extension Core {
    
    var child: Machine<Event, Event> {
        let reducer = CoreClassicMachine<State<Event>, Event, Event>(
            CoreClassicResult<State<Event>, Event>.set(domain)
        ) { state, event in
            var isSkippable = true
            let mapped: State<Event>
            switch state.transit(event) {
            case .skip:
                mapped = state
            case .set(let new):
                isSkippable = false
                mapped = new
            }

            return .set(mapped, outputs: isSkippable ? [] : [event])
        }
        
        let mapped: Machine<StateAction<Event>, StateAction<Event>> = reducer.outward { .set(.stateDidUpdate($0)) }.inward {
            switch $0 {
            case .stateDidUpdate:
                return .set()
            case .stateWillUpdate(let event):
                return .set(event)
            }
        }
        
        let merged: Machine<StateAction<Event>, StateAction<Event>> = Machine.merge(
            layers.reduce([]) { cur, layer in
                if cur.contains(where: { $0 === layer.machine }) {
                    return cur
                } else {
                    return cur.copy(add: layer.machine)
                }
            }.copy(add: mapped)
        ).redirect { .back($0) }
        
        return merged.outward { _ in Ward.set() }.inward { _ in Ward.set() }
    }
}

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
    
    
    var domain: [State<Event>] { get }
}

public extension Core {
    
    var child: Machine<Event, Event> {
        let reducer = CoreClassicMachine<[State<Event>], Event, Event>(
            CoreClassicResult<[State<Event>], Event>.set(domain)
        ) { states, event in
            var isSkippable = true
            let mapped = states.map { state -> State<Event> in
                switch state._function(event) {
                case .skip:
                    return state
                case .set(let new):
                    isSkippable = false
                    return new
                }
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


public struct State<Event> {
    
    internal let _function: Mapper<Event, ReducerResult<State<Event>>>
    
    public init(_ function: @escaping Mapper<Event, ReducerResult<State<Event>>>) {
        _function = function
    }
    
    public func map<T>(_ function: @escaping Mapper<T, ReducerResult<Event>>) -> State<T> {
        State<T> { event in
            switch function(event) {
            case .skip:
                return .skip
            case .set(let mapped):
                switch _function(mapped) {
                case .skip:
                    return .skip
                case .set(let state):
                    return .set(state.map(function))
                }
            }
        }
    }
}

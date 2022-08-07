//
//  MapOperator.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


import simprokmachine


public func map<Event, T>(_ state: State<Event>, function: @escaping Mapper<T, Map<Event>>) -> State<T> {
    state.map(function)
}

public extension State {
    
    func map<T>(_ function: @escaping Mapper<T, Map<Event>>) -> State<T> {
        State<T> { event in
            switch function(event) {
            case .skip:
                return .skip
            case .set(let mapped):
                switch transit(mapped) {
                case .skip:
                    return .skip
                case .set(let state):
                    return .set(state.map(function))
                }
            }
        }
    }
}


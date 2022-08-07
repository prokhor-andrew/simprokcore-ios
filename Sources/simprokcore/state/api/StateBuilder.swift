//
//  StateBuilder.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


import simprokmachine
import Foundation


public struct StateBuilder<T> {
 
    private let functions: [Mapper<T, Step>]
    
    public init() {
        self.functions = []
    }
    
    private init(functions: [Mapper<T, Step>]) {
        self.functions = functions
    }
    
    public func when(id: String = UUID().uuidString, is value: @autoclosure @escaping Supplier<T>) -> StateBuilder<T> where T: Equatable {
        when(id: id) { $0 == value() }
    }
    
    public func when(id: String = UUID().uuidString, not value: @autoclosure @escaping Supplier<T>) -> StateBuilder<T> where T: Equatable {
        when(id: id) { $0 != value() }
    }
    
    public func when(id: String = UUID().uuidString, _ function: @escaping Mapper<T, Bool>) -> StateBuilder<T> {
        StateBuilder(functions: functions.copy(add: {
            function($0) ? .next : .skip
        }))
    }
    
    public func `while`(id: String = UUID().uuidString, is value: @autoclosure @escaping Supplier<T>) -> StateBuilder<T> where T: Equatable {
        `while`(id: id) { $0 == value() }
    }
    
    public func `while`(id: String = UUID().uuidString, not value: @autoclosure @escaping Supplier<T>) -> StateBuilder<T> where T: Equatable {
        `while`(id: id) { $0 != value() }
    }
    
    public func `while`(id: String = UUID().uuidString, _ function: @escaping Mapper<T, Bool>) -> StateBuilder<T> {
        StateBuilder(functions: functions.copy(add: {
            function($0) ? .current : .next
        }))
    }
    
    public func until(id: String = UUID().uuidString, is value: @autoclosure @escaping Supplier<T>) -> StateBuilder<T> where T: Equatable {
        until(id: id) { $0 == value() }
    }
    
    public func until(id: String = UUID().uuidString, not value: @autoclosure @escaping Supplier<T>) -> StateBuilder<T> where T: Equatable {
        until(id: id) { $0 != value() }
    }
    
    public func until(id: String = UUID().uuidString, _ function: @escaping Mapper<T, Bool>) -> StateBuilder<T> {
        StateBuilder(functions: functions.copy(add: {
            function($0) ? .next : .current
        }))
    }
    
    public func connect(to state: @autoclosure @escaping Supplier<State<T>>) -> State<T> {
        generate(index: 0, end: state())
    }
    
    public func final() -> State<T> {
        connect(to: final())
    }
    
    public func or(_ states: @autoclosure @escaping Supplier<[State<T>]>) -> State<T> {
        connect(to: or(states()))
    }
    
    public func and(
        _ states: @autoclosure @escaping Supplier<[State<T>]>,
        transit: @escaping BiMapper<[State<T>], T, AndTransition<T>> = { states, event in
            .upd(Set(states.enumerated().map { index, _ in index }))
        }
    ) -> State<T> {
        connect(to: and(states(), transit: transit))
    }
    
    private func generate(index: Int, end state: @autoclosure @escaping Supplier<State<T>>) -> State<T> {
        State<T> { event in
            if index >= functions.count {
                return .set(state())
            } else {
                switch functions[index](event) {
                case .skip:
                    return .skip
                case .current:
                    return .set(generate(index: index, end: state()))
                case .next:
                    return .set(generate(index: index + 1, end: state()))
                }
            }
        }
    }
}

private enum Step {
    case next
    case current
    case skip
}

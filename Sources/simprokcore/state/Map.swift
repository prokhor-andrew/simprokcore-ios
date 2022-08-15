//
//  Map.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine



public func map1<Event, T>(
    _ state: State<Event>,
    function: @escaping BiMapper<State<Event>, T, Ward<Event>>
) -> State<T> {
    state.map1(function)
}

public func map2<Event, T>(
    _ state: State<Event>,
    function: @escaping BiMapper<State<Event>, T, Ward<Event>>
) -> State<T> {
    state.map2(function)
}

public extension State {
    
    static func map1<T>(
        _ state: State<Event>,
        function: @escaping BiMapper<Self, T, Ward<Event>>
    ) -> State<T> {
        state.map1(function)
    }
    
    static func map2<T>(
        _ state: State<Event>,
        function: @escaping BiMapper<Self, T, Ward<Event>>
    ) -> State<T> {
        state.map2(function)
    }
    
    func map1<T>(_ function: @escaping BiMapper<Self, T, Ward<Event>>) -> State<T> {
        State<T> { event in
            if let state = generate1(current: nil, events: function(self, event).values, index: 0) {
                return .set(state.map1(function))
            } else {
                return .skip
            }
        }
    }
    
    func map2<T>(_ function: @escaping BiMapper<Self, T, Ward<Event>>) -> State<T> {
        State<T> { event in
            let result = function(self, event).values
            if result.isEmpty {
                return .skip
            } else {
                if let state = generate2(events: result, index: 0) {
                    return .set(state.map2(function))
                } else {
                    return .skip
                }
            }
        }
    }
    
    private func generate1(current: State<Event>?, events: [Event], index: Int) -> State<Event>? {
        if index >= events.count {
            return current
        }
        
        switch transit(events[index]) {
        case .set(let new):
            return new.generate1(current: new, events: events, index: index + 1)
        case .skip:
            return current
        }
    }
    
    private func generate2(events: [Event], index: Int) -> State<Event>? {
        if index >= events.count {
            return self
        }
        
        switch transit(events[index]) {
        case .set(let new):
            return new.generate2(events: events, index: index + 1)
        case .skip:
            return nil
        }
    }
}

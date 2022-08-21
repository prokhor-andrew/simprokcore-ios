//
//  Or.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import Foundation


public func or<Event>(_ states: @autoclosure @escaping () -> [State<Event>]) -> State<Event> {
    State.or(states())
}

public extension State {
    
    static func or(
        _ states: @autoclosure @escaping () -> [State<Event>]
    ) -> State<Event> {
        State<Event> { event in
            for state in states() {
                let result = state.transit(event)
                switch result {
                case .skip:
                    continue
                case .set(let new):
                    return .set(new.set(causing: event))
                }
            }
            return .skip
        }
    }
}

public extension StateBuilder {
    
    func or(_ states: @autoclosure @escaping () -> [State<Event>]) -> State<Event> {
        link(to: State.or(states()))
    }
}

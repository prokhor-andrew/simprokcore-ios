//
//  AndOperator.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


import simprokmachine


public enum AndTransition<Event> {
    case set(State<Event>)
    case upd(Set<Int>)
    
    public static func upd(_ indexes: Int...) -> AndTransition<Event> {
        .upd(Set(indexes))
    }
}


public func and<Event: Equatable>(
    _ states: @autoclosure @escaping () -> [State<Event>],
    transition: @escaping BiMapper<[State<Event>], Event, AndTransition<Event>> = { states, event in
            .upd(Set(states.enumerated().map { index, _ in index }))
        }
) -> State<Event> {
    State<Event> { event in
        let states = states()
        switch transition(states, event) {
        case .set(let state):
            return .set(state)
        case .upd(let indexes):
            if indexes.isEmpty {
                return .skip
            } else {
                var skippable = true
                let new: [State<Event>] = states.enumerated().map { index, state in
                    if indexes.contains(index) {
                        switch state.transit(event) {
                        case .skip:
                            return state
                        case .set(let new):
                            skippable = false
                            return new
                        }
                    } else {
                        return state
                    }
                }
                
                return skippable ? .skip : .set(and(new, transition: transition))
            }
        }
    }
}

public func or<Event: Equatable>(_ states: @autoclosure @escaping () -> [State<Event>]) -> State<Event> {
    State<Event> { event in
        for state in states() {
            let result = state.transit(event)
            switch result {
            case .skip:
                continue
            case .set(let new):
                return .set(new)
            }
        }
        return .skip
    }
}


public func final<Event>() -> State<Event> {
    State { _ in .skip }
}


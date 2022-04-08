//
//  CoreReducerMachine.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

// a copy from simproktools
internal final class CoreReducerMachine<Event, State>: ParentMachine {
    internal typealias Input = Event
    internal typealias Output = State
    
    internal let child: Machine<Input, Output>
    
    internal init(reducer: @escaping BiMapper<State?, Event, ReducerResult<State>>) {
        self.child = ~CoreClassicMachine<State?, Event, State>(.set(nil), reducer: {
            switch reducer($0, $1) {
            case .set(let state):
                return .set(state, outputs: state)
            case .skip:
                return .set($0)
            }
        })
    }
}


//
//  Spawn.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import Foundation



public extension State {
    
    func spawn() -> State<Event> {
        .spawn(self)
    }
    
    static func spawn(_ state: State<Event>) -> State<Event> {
        State { event in
            switch state.transit(event) {
            case .skip:
                return .skip
            case .set(let new):
                return .set(.merge([new, state.spawn()]))
            }
        }
    }
}

public func spawn<Event>(_ state: State<Event>) -> State<Event> {
    .spawn(state)
}

//
//  StateAction.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// This enum is public for implementation reasons only. It should not be used directly.
public enum StateAction<State, Event> {
    case stateWillUpdate(Event)
    case stateDidUpdate(State)
}

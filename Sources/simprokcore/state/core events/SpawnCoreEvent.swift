//
//  SpawnCoreEvent.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.



public extension State where Event: CoreEvent {
    
    func spawn() -> State<Event.Event> {
        map(Event.map(event:)).spawn()
    }

    static func spawn(_ state: @autoclosure @escaping () -> State<Event>) -> State<Event.Event> {
        state().spawn()
    }
}

public extension StateWrapper {
    func spawn() -> State<Event> {
        state.spawn()
    }

    static func spawn(_ state: @autoclosure @escaping () -> StateWrapper<Event>) -> State<Event> {
        state().spawn()
    }
}


public func spawn<Event: CoreEvent>(_ state: @autoclosure @escaping () -> State<Event>) -> State<Event.Event> {
    State.spawn(state())
}

public func spawn<Event>(_ state: @autoclosure @escaping () -> StateWrapper<Event>) -> State<Event> {
    StateWrapper.spawn(state())
}

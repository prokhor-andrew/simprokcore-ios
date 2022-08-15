//
//  Connect.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


import simprokmachine

public enum Connect<Data, Event> {
    case skip
    case set(Data, State<Event>)
}

public func connect<Event>(
    function: @escaping BiMapper<State<Event>?, Event, Transition<State<Event>>>
) -> State<Event> {
    State.connect(function: function)
}

public func connect2<Data, Event>(
    _ data: Data,
    function: @escaping TriMapper<State<Event>?, Data, Event, Connect<Data, Event>>
) -> State<Event> {
    State<Event>.connect2(data, function: function)
}

public func connect2<Data, Event>(
    function: @escaping TriMapper<State<Event>?, Data?, Event, Connect<Data, Event>>
) -> State<Event> {
    State<Event>.connect2(function: function)
}

public extension State {
    
    static func connect(
        function: @escaping BiMapper<State<Event>?, Event, Transition<State<Event>>>
    ) -> State<Event> {
        State { event in
            switch function(nil, event) {
            case .skip:
                return .skip
            case .set(let new):
                switch new.transit(event) {
                case .skip:
                    return .set(connect1(new, function: function))
                case .set(let new2):
                    return .set(connect1(new2, function: function))
                }
            }
        }
    }
    
    static func connect2<Data, Event>(
        _ data: Data,
        function: @escaping TriMapper<State<Event>?, Data, Event, Connect<Data, Event>>
    ) -> State<Event> {
        State<Event> { event in
            switch function(nil, data, event) {
            case .skip:
                return .skip
            case .set(let newData, let newState):
                switch newState.transit(event) {
                case .skip:
                    return .set(simprokcore.connect2(newData, newState, function: function))
                case .set(let newState2):
                    return .set(simprokcore.connect2(newData, newState2, function: function))
                }
            }
        }
    }

    static func connect2<Data, Event>(
        function: @escaping TriMapper<State<Event>?, Data?, Event, Connect<Data, Event>>
    ) -> State<Event> {
        State<Event> { event in
            switch function(nil, nil, event) {
            case .skip:
                return .skip
            case .set(let newData, let newState):
                switch newState.transit(event) {
                case .skip:
                    return .set(simprokcore.connect2(newData, newState, function: function))
                case .set(let newState2):
                    return .set(simprokcore.connect2(newData, newState2, function: function))
                }
            }
        }
    }
}

public extension StateBuilder {
    
    func connect(
        function: @escaping BiMapper<State<Event>?, Event, Transition<State<Event>>>
    ) -> State<Event> {
        link(to: State.connect(function: function))
    }
    
    func connect2<Data>(
        function: @escaping TriMapper<State<Event>?, Data?, Event, Connect<Data, Event>>
    ) -> State<Event> {
        link(to: State<Event>.connect2(function: function))
    }
    
    func connect2<Data>(
        _ data: Data,
        function: @escaping TriMapper<State<Event>?, Data, Event, Connect<Data, Event>>
    ) -> State<Event> {
        link(to: State<Event>.connect2(data, function: function))
    }
}

private func connect1<Event>(
    _ initial: State<Event>,
    function: @escaping BiMapper<State<Event>, Event, Transition<State<Event>>>
) -> State<Event> {
    State { event in
        switch function(initial, event) {
        case .skip:
            return .skip
        case .set(let new):
            switch new.transit(event) {
            case .skip:
                return .set(connect1(new, function: function))
            case .set(let new2):
                return .set(connect1(new2, function: function))
            }
        }
    }
}


private func connect2<Data, Event>(
    _ data: Data,
    _ state: State<Event>,
    function: @escaping TriMapper<State<Event>, Data, Event, Connect<Data, Event>>
) -> State<Event> {
    State { event in
        switch function(state, data, event) {
        case .skip:
            return .skip
        case .set(let newData, let newState):
            switch newState.transit(event) {
            case .skip:
                return .set(connect2(newData, newState, function: function))
            case .set(let newState2):
                return .set(connect2(newData, newState2, function: function))
            }
        }
    }
}

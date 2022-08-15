//
//  Register.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public enum Register<Data, Event> {
    case skip
    case set(Data, State<Event>?)
}

public func register<Event>(
    _ state: State<Event>,
    function: @escaping TriMapper<State<Event>, State<Event>?, Event, Transition<State<Event>?>>
) -> State<Event> {
    state.register(function: function)
}

public func register<Data, Event>(
    _ state: State<Event>,
    function: @escaping (Data?, State<Event>, State<Event>?, Event) -> Register<Data, Event>
) -> State<Event> {
    state.register(function: function)
}

public func register<Data, Event>(
    _ state: State<Event>,
    _ data: Data,
    function: @escaping (Data, State<Event>, State<Event>?, Event) -> Register<Data, Event>
) -> State<Event> {
    state.register(data, function: function)
}

public extension State {
    
    static func register(
        _ state: State<Event>,
        function: @escaping TriMapper<State<Event>, State<Event>?, Event, Transition<State<Event>?>>
    ) -> State<Event> {
        state.register(function: function)
    }
    
    static func register<Data, Event>(
        _ state: State<Event>,
        _ data: Data,
        function: @escaping (Data, State<Event>, State<Event>?, Event) -> Register<Data, Event>
    ) -> State<Event> {
        state.register(data, function: function)
    }
    
    static func register<Data, Event>(
        _ state: State<Event>,
        function: @escaping (Data?, State<Event>, State<Event>?, Event) -> Register<Data, Event>
    ) -> State<Event> {
        state.register(function: function)
    }
    
    func register<Data>(
        function: @escaping (Data?, State<Event>, State<Event>?, Event) -> Register<Data, Event>
    ) -> State<Event> {
        State.connect2(RegisterData<Data, Event>(data: nil, main: self, sec: nil)) { _, data, event in
            switch function(data.data, data.main, data.sec, event) {
            case .skip:
                switch data.main.transit(event) {
                case .skip:
                    return .skip
                case .set(let new):
                    let newData = RegisterData(data: data.data, main: new, sec: data.sec)
                    if let secState = data.sec {
                        return .set(
                            newData,
                            State.merge([new, secState])
                        )
                    } else {
                        return .set(newData, new)
                    }
                }
            case .set(let newData, let new):
                switch data.main.transit(event) {
                case .skip:
                    if let new = new {
                        switch new.transit(event) {
                        case .skip:
                            return .set(RegisterData(data: newData, main: data.main, sec: new), State.merge([data.main, new]))
                        case .set(let new2):
                            return .set(RegisterData(data: newData, main: data.main, sec: new2), State.merge([data.main, new2]))
                        }
                    } else {
                        return .set(RegisterData(data: newData, main: data.main, sec: nil), data.main)
                    }
                case .set(let newMain):
                    if let new = new {
                        switch new.transit(event) {
                        case .skip:
                            return .set(RegisterData(data: newData, main: newMain, sec: new), State.merge([newMain, new]))
                        case .set(let new2):
                            return .set(RegisterData(data: newData, main: newMain, sec: new2), State.merge([newMain, new2]))
                        }
                    } else {
                        return .set(RegisterData(data: newData, main: newMain, sec: nil), newMain)
                    }
                }
            }
        }
    }
    
    func register<Data>(
        _ data: Data,
        function: @escaping (Data, State<Event>, State<Event>?, Event) -> Register<Data, Event>
    ) -> State<Event> {
        State.connect2(RegisterData(data: data, main: self, sec: nil)) { _, data, event in
            switch function(data.data!, data.main, data.sec, event) {
            case .skip:
                switch data.main.transit(event) {
                case .skip:
                    return .skip
                case .set(let new):
                    let newData = RegisterData(data: data.data, main: new, sec: data.sec)
                    if let secState = data.sec {
                        return .set(
                            newData,
                            State.merge([new, secState])
                        )
                    } else {
                        return .set(newData, new)
                    }
                }
            case .set(let newData, let new):
                switch data.main.transit(event) {
                case .skip:
                    if let new = new {
                        switch new.transit(event) {
                        case .skip:
                            return .set(RegisterData(data: newData, main: data.main, sec: new), State.merge([data.main, new]))
                        case .set(let new2):
                            return .set(RegisterData(data: newData, main: data.main, sec: new2), State.merge([data.main, new2]))
                        }
                    } else {
                        return .set(RegisterData(data: newData, main: data.main, sec: nil), data.main)
                    }
                case .set(let newMain):
                    if let new = new {
                        switch new.transit(event) {
                        case .skip:
                            return .set(RegisterData(data: newData, main: newMain, sec: new), State.merge([newMain, new]))
                        case .set(let new2):
                            return .set(RegisterData(data: newData, main: newMain, sec: new2), State.merge([newMain, new2]))
                        }
                    } else {
                        return .set(RegisterData(data: newData, main: newMain, sec: nil), newMain)
                    }
                }
            }
        }
    }
    
    func register(
        function: @escaping TriMapper<State<Event>, State<Event>?, Event, Transition<State<Event>?>>
    ) -> State<Event> {
        State.connect2(RegisterData<Void, Event>(data: nil, main: self, sec: nil)) { _, data, event in
            switch function(data.main, data.sec, event) {
            case .skip:
                switch data.main.transit(event) {
                case .skip:
                    return .skip
                case .set(let new):
                    let newData = RegisterData<Void, Event>(data: nil, main: new, sec: data.sec)
                    if let secState = data.sec {
                        return .set(
                            newData,
                            State.merge([new, secState])
                        )
                    } else {
                        return .set(newData, new)
                    }
                }
            case .set(let new):
                switch data.main.transit(event) {
                case .skip:
                    if let new = new {
                        switch new.transit(event) {
                        case .skip:
                            return .set(RegisterData<Void, Event>(data: nil, main: data.main, sec: new), State.merge([data.main, new]))
                        case .set(let new2):
                            return .set(RegisterData<Void, Event>(data: nil, main: data.main, sec: new2), State.merge([data.main, new2]))
                        }
                    } else {
                        return .set(RegisterData<Void, Event>(data: nil, main: data.main, sec: nil), data.main)
                    }
                case .set(let newMain):
                    if let new = new {
                        switch new.transit(event) {
                        case .skip:
                            return .set(RegisterData<Void, Event>(data: nil, main: newMain, sec: new), State.merge([newMain, new]))
                        case .set(let new2):
                            return .set(RegisterData<Void, Event>(data: nil, main: newMain, sec: new2), State.merge([newMain, new2]))
                        }
                    } else {
                        return .set(RegisterData<Void, Event>(data: nil, main: newMain, sec: nil), newMain)
                    }
                }
            }
        }
    }
}


private struct RegisterData<Data, Event> {
    
    let data: Data?
    let main: State<Event>
    let sec: State<Event>?
}

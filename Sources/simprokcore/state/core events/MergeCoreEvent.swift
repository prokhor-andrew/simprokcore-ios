//
//  MergeCoreEvent.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public extension State {

    static func merge(_ states: @autoclosure @escaping () -> [StateWrapper<Event>]) -> State<Event> {
        .merge(states().map { $0.state })
    }
}

public extension StateWrapper {
    
    static func merge(_ states: @autoclosure @escaping () -> [StateWrapper<Event>]) -> State<Event> {
        .merge(states())
    }
}

public func merge<Event>(_ states: @autoclosure @escaping () -> [StateWrapper<Event>]) -> State<Event> {
    .merge(states())
}


public extension State where Event: CoreEvent {
    
    func and<T: CoreEvent>(_ state: @autoclosure @escaping () -> State<T>) -> State<Event.Event> where T.Event == Event.Event {
        fatalError()
    }
    
    func and<T: CoreEvent>(_ state: @autoclosure @escaping () -> [State<T>]) -> State<Event.Event> where T.Event == Event.Event {
        fatalError()
    }

    func and(_ state: @autoclosure @escaping () -> StateWrapper<Event.Event>) -> State<Event.Event> {
        fatalError()
    }
    
    func and(_ state: @autoclosure @escaping () -> [StateWrapper<Event.Event>]) -> State<Event.Event> {
        fatalError()
    }

    func and<E>(_ state: @autoclosure @escaping () -> State<E>) -> State<E> where Event.Event == E {
        fatalError()
    }
    
    func and<E>(_ state: @autoclosure @escaping () -> [State<E>]) -> State<E> where Event.Event == E {
        fatalError()
    }
}

public extension State {
    
    func and<C: CoreEvent>(_ state: @autoclosure @escaping () -> State<C>) -> State<Event> where C.Event == Event {
        fatalError()
    }
    
    func and<C: CoreEvent>(_ state: @autoclosure @escaping () -> [State<C>]) -> State<Event> where C.Event == Event {
        fatalError()
    }
    
    func and(_ state: @autoclosure @escaping () -> StateWrapper<Event>) -> State<Event> {
        fatalError()
    }
    
    func and(_ state: @autoclosure @escaping () -> [StateWrapper<Event>]) -> State<Event> {
        fatalError()
    }
}

public extension StateWrapper {
    
    func and(_ state: @autoclosure @escaping () -> StateWrapper<Event>) -> State<Event> {
        fatalError()
    }
    
    func and<E: CoreEvent>(_ state: @autoclosure @escaping () -> State<E>) -> State<Event> where E.Event == Event {
        fatalError()
    }
    
    func and(_ state: @autoclosure @escaping () -> State<Event>) -> State<Event> {
        fatalError()
    }
    
}

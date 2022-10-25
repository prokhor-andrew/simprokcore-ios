//
//  MappableUntilNot.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public func until<Event: MappableEvent & Equatable, Event2: MappableEvent>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    State<Event.Event>.until(not: event(), next: state())
}

public func until<Event: MappableEvent & Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    State<Event.Event>.until(not: event(), next: state())
}

public func until<Event: MappableEvent & Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    State<Event.Event>.until(not: event(), next: state())
}

public func until<Event: MappableEvent, Event2: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    State<Event.Event>.until(not: condition(), next: state())
}

public func until<Event: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    State<Event.Event>.until(not: condition(), next: state())
}

public func until<Event: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    State<Event.Event>.until(not: condition(), next: state())
}


public extension State {
    
    static func until<E1: MappableEvent & Equatable, E2: MappableEvent>(
        not event: @autoclosure @escaping Supplier<E1>,
        next state: @autoclosure @escaping Supplier<State<E2>>
    ) -> State<Event> where E1.Event == Event, E2.Event == Event {
        State<Event>.while(is: event(), next: state())
    }
    
    static func until<E: MappableEvent & Equatable>(
        not event: @autoclosure @escaping Supplier<E>,
        next state: @autoclosure @escaping Supplier<State<E>>
    ) -> State<Event> where E.Event == Event {
        State<Event>.while(is: event(), next: state())
    }
    
    static func until<E: MappableEvent & Equatable>(
        not event: @autoclosure @escaping Supplier<E>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> where E.Event == Event {
        State<Event>.while(is: event(), next: state())
    }
    
    static func until<E1: MappableEvent, E2: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E1>>,
        next state: @autoclosure @escaping Supplier<State<E2>>
    ) -> State<Event> where E1.Event == Event, E2.Event == Event {
        State<Event>.while(is: condition(), next: state())
    }
    
    static func until<E: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E>>,
        next state: @autoclosure @escaping Supplier<State<E>>
    ) -> State<Event> where E.Event == Event {
        State<Event>.while(is: condition(), next: state())
    }
    
    static func until<E: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> where E.Event == Event {
        State<Event>.while(is: condition(), next: state())
    }
}

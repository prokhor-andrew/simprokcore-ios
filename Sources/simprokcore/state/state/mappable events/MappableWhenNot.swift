//
//  MappableWhenNot.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public func when<Event: MappableEvent & Equatable, Event2: MappableEvent>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    State<Event.Event>.when(not: event(), next: state())
}

public func when<Event: MappableEvent & Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    State<Event.Event>.when(not: event(), next: state())
}

public func when<Event: MappableEvent & Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    State<Event.Event>.when(not: event(), next: state())
}

public func when<Event: MappableEvent, Event2: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    State<Event.Event>.when(not: condition(), next: state())
}

public func when<Event: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    State<Event.Event>.when(not: condition(), next: state())
}

public func when<Event: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    State<Event.Event>.when(not: condition(), next: state())
}


public extension State {
    

    static func when<E1: MappableEvent & Equatable, E2: MappableEvent>(
        not event: @autoclosure @escaping Supplier<E1>,
        next state: @autoclosure @escaping Supplier<State<E2>>
    ) -> State<Event> where E1.Event == Event, E2.Event == Event {
        event() !=> state()
    }
    
    static func when<E: MappableEvent & Equatable>(
        not event: @autoclosure @escaping Supplier<E>,
        next state: @autoclosure @escaping Supplier<State<E>>
    ) -> State<Event> where E.Event == Event {
        event() !=> state()
    }
    
    static func when<E: MappableEvent & Equatable>(
        not event: @autoclosure @escaping Supplier<E>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> where E.Event == Event {
        event() !=> state()
    }
    
    static func when<E1: MappableEvent, E2: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E1>>,
        next state: @autoclosure @escaping Supplier<State<E2>>
    ) -> State<Event> where E1.Event == Event, E2.Event == Event {
        condition() !=> state()
    }
    
    static func when<E: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E>>,
        next state: @autoclosure @escaping Supplier<State<E>>
    ) -> State<Event> where E.Event == Event {
        condition() !=> state()
    }
    
    static func when<E: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> where E.Event == Event {
        condition() !=> state()
    }
    
}

public func !=><Event: MappableEvent & Equatable, Event2: MappableEvent>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    Condition { event in
        event != lhs()
    } ==> rhs()
}

public func !=><Event: MappableEvent & Equatable>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    Condition { event in
        event != lhs()
    } ==> rhs()
}

public func !=><Event: MappableEvent & Equatable>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    Condition { event in
        event != lhs()
    } ==> rhs()
}

public func !=><Event: MappableEvent, Event2: MappableEvent>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    Condition { event in
        !lhs().predicate(event)
    } ==> rhs()
}

public func !=><Event: MappableEvent>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    Condition { event in
        !lhs().predicate(event)
    } ==> rhs()
}

public func !=><Event: MappableEvent>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    Condition { event in
        !lhs().predicate(event)
    } ==> rhs()
}
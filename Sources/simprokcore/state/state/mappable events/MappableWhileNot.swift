//
//  MappableWhileNot.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public func `while`<Event: MappableEvent & Equatable, Event2: MappableEvent>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    State<Event.Event>.while(not: event(), next: state())
}

public func `while`<Event: MappableEvent & Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    State<Event.Event>.while(not: event(), next: state())
}

public func `while`<Event: MappableEvent & Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    State<Event.Event>.while(not: event(), next: state())
}

public func `while`<Event: MappableEvent, Event2: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    State<Event.Event>.while(not: condition(), next: state())
}

public func `while`<Event: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    State<Event.Event>.while(not: condition(), next: state())
}

public func `while`<Event: MappableEvent>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    State<Event.Event>.while(not: condition(), next: state())
}


public extension State {
    

    static func `while`<E1: MappableEvent & Equatable, E2: MappableEvent>(
        not event: @autoclosure @escaping Supplier<E1>,
        next state: @autoclosure @escaping Supplier<State<E2>>
    ) -> State<Event> where E1.Event == Event, E2.Event == Event {
        event() <=> state()
    }
    
    static func `while`<E: MappableEvent & Equatable>(
        not event: @autoclosure @escaping Supplier<E>,
        next state: @autoclosure @escaping Supplier<State<E>>
    ) -> State<Event> where E.Event == Event {
        event() <=> state()
    }
    
    static func `while`<E: MappableEvent & Equatable>(
        not event: @autoclosure @escaping Supplier<E>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> where E.Event == Event {
        event() <=> state()
    }
    
    static func `while`<E1: MappableEvent, E2: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E1>>,
        next state: @autoclosure @escaping Supplier<State<E2>>
    ) -> State<Event> where E1.Event == Event, E2.Event == Event {
        condition() <=> state()
    }
    
    static func `while`<E: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E>>,
        next state: @autoclosure @escaping Supplier<State<E>>
    ) -> State<Event> where E.Event == Event {
        condition() <=> state()
    }
    
    static func `while`<E: MappableEvent>(
        not condition: @autoclosure @escaping Supplier<Condition<E>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> where E.Event == Event {
        condition() <=> state()
    }
    
}

public func <=><Event: MappableEvent & Equatable, Event2: MappableEvent>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    State<Event.Event> { event in
        switch Event.map(event: event) {
        case .skip:
            return .skip
        case .set(let value):
            if lhs() == value {
                return .set(rhs().map(Event2.map(event:)))
            } else {
                return .set(lhs() <=> rhs())
            }
        }
    }
}

public func <=><Event: MappableEvent & Equatable>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    State<Event.Event> { event in
        switch Event.map(event: event) {
        case .skip:
            return .skip
        case .set(let value):
            if lhs() == value {
                return .set(rhs().map(Event.map(event:)))
            } else {
                return .set(lhs() <=> rhs())
            }
        }
    }
}

public func <=><Event: MappableEvent & Equatable>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    State<Event.Event> { event in
        switch Event.map(event: event) {
        case .skip:
            return .skip
        case .set(let value):
            if lhs() == value {
                return .set(rhs())
            } else {
                return .set(lhs() <=> rhs())
            }
        }
    }
}

public func <=><Event: MappableEvent, Event2: MappableEvent>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event2>>
) -> State<Event.Event> where Event.Event == Event2.Event {
    State<Event.Event> { event in
        switch Event.map(event: event) {
        case .skip:
            return .skip
        case .set(let value):
            if lhs().predicate(value) {
                return .set(rhs().map(Event2.map(event:)))
            } else {
                return .set(lhs() <=> rhs())
            }
        }
    }
}

public func <=><Event: MappableEvent>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event.Event> {
    State<Event.Event> { event in
        switch Event.map(event: event) {
        case .skip:
            return .skip
        case .set(let value):
            if lhs().predicate(value) {
                return .set(rhs().map(Event.map(event:)))
            } else {
                return .set(lhs() <=> rhs())
            }
        }
    }
}

public func <=><Event: MappableEvent>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event.Event>>
) -> State<Event.Event> {
    State<Event.Event> { event in
        switch Event.map(event: event) {
        case .skip:
            return .skip
        case .set(let value):
            if lhs().predicate(value) {
                return .set(rhs())
            } else {
                return .set(lhs() <=> rhs())
            }
        }
    }
}


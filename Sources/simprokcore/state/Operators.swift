//
//  Operators.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


infix operator ==>: AssignmentPrecedence
infix operator !=>: AssignmentPrecedence
infix operator <=>: AssignmentPrecedence
infix operator <!>: AssignmentPrecedence


public func ==><Event>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> where Event: Equatable {
    State { event in
        event == lhs() ? .set(rhs().set(causing: event)) : .skip
    }
}

public func !=><Event>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> where Event: Equatable {
    State { event in
        event != lhs() ? .set(rhs().set(causing: event)) : .skip
    }
}

public func <=><Event>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> where Event: Equatable {
    State { event in
        event == lhs() ? .set(rhs().set(causing: event)) : .set((lhs() <=> rhs()).set(causing: event))
    }
}


public func <!><Event>(
    lhs: @autoclosure @escaping Supplier<Event>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> where Event: Equatable {
    State { event in
        event != lhs() ? .set(rhs().set(causing: event)) : .set((lhs() <!> rhs()).set(causing: event))
    }
}


public func ==><Event>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    State { event in
        lhs().predicate(event) ? .set(rhs().set(causing: event)) : .skip
    }
}


public func !=><Event>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    State { event in
        !lhs().predicate(event) ? .set(rhs().set(causing: event)) : .skip
    }
}

public func <=><Event>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    State { event in
        lhs().predicate(event) ? .set(rhs().set(causing: event)) : .set((lhs() <=> rhs()).set(causing: event))
    }
}

public func <!><Event>(
    lhs: @autoclosure @escaping Supplier<Condition<Event>>,
    rhs: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    State { event in
        !lhs().predicate(event) ? .set(rhs().set(causing: event)) : .set((lhs() <=> rhs()).set(causing: event))
    }
}

//
//  Global.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public func when<Event: Equatable>(
    is event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .when(is: event(), next: state())
}

public func when<Event>(
    is condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .when(is: condition(), next: state())
}

public func when<Event: Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .when(not: event(), next: state())
}


public func when<Event>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .when(not: condition(), next: state())
}

public func `while`<Event: Equatable>(
    is event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .while(is: event(), next: state())
}

public func `while`<Event>(
    is condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .while(is: condition(), next: state())
}

public func `while`<Event: Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .while(not: event(), next: state())
}

public func `while`<Event>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .while(not: condition(), next: state())
}


public func until<Event: Equatable>(
    is event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .until(is: event(), next: state())
}

public func until<Event>(
    is condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .until(is: condition(), next: state())
}

public func until<Event: Equatable>(
    not event: @autoclosure @escaping Supplier<Event>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .until(not: event(), next: state())
}

public func until<Event>(
    not condition: @autoclosure @escaping Supplier<Condition<Event>>,
    next state: @autoclosure @escaping Supplier<State<Event>>
) -> State<Event> {
    .until(not: condition(), next: state())
}


public extension State {
    
    static func when<Event: Equatable>(
        is event: @autoclosure @escaping Supplier<Event>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        event() ==> state()
    }

    static func when<Event>(
        is condition: @autoclosure @escaping Supplier<Condition<Event>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        condition() ==> state()
    }

    static func when<Event: Equatable>(
        not event: @autoclosure @escaping Supplier<Event>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        event() !=> state()
    }


    static func when<Event>(
        not condition: @autoclosure @escaping Supplier<Condition<Event>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        condition() !=> state()
    }

    static func `while`<Event: Equatable>(
        is event: @autoclosure @escaping Supplier<Event>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        event() <!> state()
    }

    static func `while`<Event>(
        is condition: @autoclosure @escaping Supplier<Condition<Event>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        condition() <!> state()
    }

    static func `while`<Event: Equatable>(
        not event: @autoclosure @escaping Supplier<Event>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        event() <=> state()
    }

    static func `while`<Event>(
        not condition: @autoclosure @escaping Supplier<Condition<Event>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        condition() <=> state()
    }


    static func until<Event: Equatable>(
        is event: @autoclosure @escaping Supplier<Event>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        `while`(not: event(), next: state())
    }

    static func until<Event>(
        is condition: @autoclosure @escaping Supplier<Condition<Event>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        `while`(not: condition(), next: state())
    }

    static func until<Event: Equatable>(
        not event: @autoclosure @escaping Supplier<Event>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        `while`(is: event(), next: state())
    }

    static func until<Event>(
        not condition: @autoclosure @escaping Supplier<Condition<Event>>,
        next state: @autoclosure @escaping Supplier<State<Event>>
    ) -> State<Event> {
        `while`(is: condition(), next: state())
    }
}

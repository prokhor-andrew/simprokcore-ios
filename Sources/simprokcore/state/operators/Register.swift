//
//  Register.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public extension State {

    func register(
        function: @escaping Mapper<Event, Transition<State<Event>>>
    ) -> State<Event> {
        register(sub: .final(), function: function)
    }
    
    private func register(
        sub: State<Event>,
        function: @escaping Mapper<Event, Transition<State<Event>>>
    ) -> State<Event> {
        State { event in
            switch transit(event) {
            case .skip:
                return .skip
            case .set(let new):
                switch function(event) {
                case .skip:
                    return .set(new.register(sub: sub, function: function))
                case .set(let sub):
                    return .set(new.register(sub: sub, function: function))
                }
            }
        }.and(sub)
    }
}



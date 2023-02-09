//
//  Mappers.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simprokstate


internal extension Machine {
    
    func inward<ParentInput>(_ function: @escaping Mapper<ParentInput, [Input]>) -> Machine<ParentInput, Output> {
        
        func feature() -> Feature<Output, Input, ParentInput, Output> {
            Feature(machines: [self]) { _, event in
                switch event {
                case .int(let value):
                    return Feature.Transition(feature(), effects: .ext(value))
                case .ext(let value):
                    return Feature.Transition(feature(), effects: function(value).map { .int($0) })
                }
            }
        }

        return Machine<ParentInput, Output>(Feature.Transition(feature()))
    }
    
    func outward<ParentOutput>(_ function: @escaping Mapper<Output, [ParentOutput]>) -> Machine<Input, ParentOutput> {
        
        func feature() -> Feature<Output, Input, Input, ParentOutput> {
            Feature(machines: [self]) { _, event in
                switch event {
                case .int(let value):
                    return Feature.Transition(feature(), effects: function(value).map { .ext($0) })
                case .ext(let value):
                    return Feature.Transition(feature(), effects: .int(value))
                }
            }
        }

        return Machine<Input, ParentOutput>(Feature.Transition(feature()))
    }
}

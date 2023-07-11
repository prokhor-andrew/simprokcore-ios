//
//  Mappers.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simprokstate


internal extension Machine {
    
    func inward<ParentInput>(_ function: @escaping (ParentInput) -> [Input]) -> Machine<ParentInput, Output> {
        
        @Sendable
        func feature() -> Feature<Output, Input, ParentInput, Output> {
            Feature.create(SetOfMachines(self)) { _, event in
                switch event {
                case .int(let value):
                    return FeatureTransition(feature(), effects: .ext(value))
                case .ext(let value):
                    return FeatureTransition(feature(), effects: function(value).map { .int($0) })
                }
            }
        }

        return Machine<ParentInput, Output>(feature)
    }
    
    func outward<ParentOutput>(_ function: @escaping (Output) -> [ParentOutput]) -> Machine<Input, ParentOutput> {
        
        @Sendable
        func feature() -> Feature<Output, Input, Input, ParentOutput> {
            Feature.create(SetOfMachines(self)) { _, event in
                switch event {
                case .int(let value):
                    return FeatureTransition(feature(), effects: function(value).map { .ext($0) })
                case .ext(let value):
                    return FeatureTransition(feature(), effects: .int(value))
                }
            }
        }

        return Machine<Input, ParentOutput>(feature)
    }
}

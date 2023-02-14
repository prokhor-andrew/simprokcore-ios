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
            Feature(SetOfMachines(self)) { _, event in
                switch event {
                case .int(let value):
                    return FeatureTransition(feature(), effects: .ext(value))
                case .ext(let value):
                    return FeatureTransition(feature(), effects: function(value).map { .int($0) })
                }
            }
        }

        return Machine<ParentInput, Output>(FeatureTransition(feature()))
    }
    
    func outward<ParentOutput>(_ function: @escaping Mapper<Output, [ParentOutput]>) -> Machine<Input, ParentOutput> {
        
        func feature() -> Feature<Output, Input, Input, ParentOutput> {
            Feature(SetOfMachines(self)) { _, event in
                switch event {
                case .int(let value):
                    return FeatureTransition(feature(), effects: function(value).map { .ext($0) })
                case .ext(let value):
                    return FeatureTransition(feature(), effects: .int(value))
                }
            }
        }

        return Machine<Input, ParentOutput>(FeatureTransition(feature()))
    }
}

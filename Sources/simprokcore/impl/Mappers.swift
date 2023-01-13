//
//  Mappers.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simprokstate


internal extension Automaton {
    
    func inward<ParentInput>(_ function: @escaping Mapper<ParentInput, [Input]>) -> FeatureMachine<Output, Input, ParentInput, Output> {
        func feature() -> FeatureSelfishObject<Output, Input, ParentInput, Output> {
            FeatureSelfishObject(machines: Machines { ParentMachine(self) }) { _, event in
                switch event {
                case .int(let value):
                    return FeatureTransition(feature(), effects: .ext(value))
                case .ext(let value):
                    return FeatureTransition(feature(), effects: function(value).map { .int($0) })
                }
            }
        }
        
        return FeatureMachine(FeatureTransition(feature()))
    }
    
    func outward<ParentOutput>(_ function: @escaping Mapper<Output, [ParentOutput]>) -> FeatureMachine<Output, Input, Input, ParentOutput> {
        func feature() -> FeatureSelfishObject<Output, Input, Input, ParentOutput> {
            FeatureSelfishObject(machines: Machines { ParentMachine(self) }) { _, event in
                switch event {
                case .int(let value):
                    return FeatureTransition(feature(), effects: function(value).map { .ext($0) })
                case .ext(let value):
                    return FeatureTransition(feature(), effects: .int(value))
                }
            }
        }
        
        return FeatureMachine(FeatureTransition(feature()))
    }
}

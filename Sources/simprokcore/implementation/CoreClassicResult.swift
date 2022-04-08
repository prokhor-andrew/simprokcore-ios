//
//  CoreClassicResult.swift
//  simproktools
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

// a copy from simproktools
internal struct CoreClassicResult<State, Output> {
    
    internal let state: State
    
    internal let outputs: [Output]
    
    private init(_ state: State, _ outputs: [Output]) {
        self.state = state
        self.outputs = outputs
    }
    
    internal static func set(_ state: State, outputs: Output...) -> CoreClassicResult<State, Output> {
        .init(state, outputs)
    }
    
    internal static func set(_ state: State, outputs: [Output]) -> CoreClassicResult<State, Output> {
        .init(state, outputs)
    }
}

//
//  CoreClassicMachine.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

// a copy from simproktools
internal final class CoreClassicMachine<State, Input, Output>: ChildMachine {
    
    private var state: CoreClassicResult<State, Output>
    private let reducer: BiMapper<State, Input, CoreClassicResult<State, Output>>
    
    internal let queue: MachineQueue
    
    internal init(
        _ initial: CoreClassicResult<State, Output>,
        queue: MachineQueue = .new,
        reducer: @escaping BiMapper<State, Input, CoreClassicResult<State, Output>>
    ) {
        self.queue = queue
        self.state = initial
        self.reducer = reducer
    }
    
    internal func process(input: Input?, callback: @escaping Handler<Output>) {
        if let input = input {
            state = reducer(state.state, input)
        }
        state.outputs.forEach { callback($0) }
    }
}

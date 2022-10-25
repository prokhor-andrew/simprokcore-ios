//
//  ClassicMachine.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


///  a copy from tools in order to remove dependency
private final class ClassicMachine<State, Input, Output>: ChildMachine {
    
    private var state: ClassicResult<State, Output>
    private let reducer: BiMapper<State, Input, ClassicResult<State, Output>>
    
    public let queue: MachineQueue
    
    public init(
        _ initial: ClassicResult<State, Output>,
        queue: MachineQueue = .new,
        reducer: @escaping BiMapper<State, Input, ClassicResult<State, Output>>
    ) {
        self.queue = queue
        self.state = initial
        self.reducer = reducer
    }
    
    public func process(input: Input?, callback: @escaping Handler<Output>) {
        if let input = input {
            state = reducer(state.state, input)
        }
        state.outputs.forEach { callback($0) }
    }
}


internal extension MachineType {
    
    static func classic<State>(
        _ initial: ClassicResult<State, Output>,
        queue: MachineQueue = .new,
        reducer: @escaping BiMapper<State, Input, ClassicResult<State, Output>>
    ) -> Machine<Input, Output> {
        ~ClassicMachine(initial, queue: queue, reducer: reducer)
    }
}


internal func classic<State, Input, Output>(
    _ initial: ClassicResult<State, Output>,
    queue: MachineQueue = .new,
    reducer: @escaping BiMapper<State, Input, ClassicResult<State, Output>>
) -> Machine<Input, Output> {
    Machine.classic(initial, queue: queue, reducer: reducer)
}

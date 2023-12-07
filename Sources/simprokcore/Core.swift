//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine
import simprokstate

public final class Core {
    
    private let story: () -> AnyStory
    private let machines: () -> [AnyMachine]
    private let handlers: () -> [MessageHandler]
    
    private var process: Process<Void, Void>?
    
    public init(
        story: @autoclosure @escaping () -> AnyStory,
        machines: @autoclosure @escaping () -> [AnyMachine],
        handlers: @autoclosure @escaping () -> [MessageHandler]
    ) {
        self.story = story
        self.machines = machines
        self.handlers = handlers
    }
    
    public func start() {
        let machines = machines()
        let story = story()
        let handlers = handlers()
        
        process = Machine { id in
            story.asIntTriggerIntEffect(
                SetOfMachines(Set(machines))
            )
        }.run { loggable in
            handlers.forEach { $0.handler(loggable) }
        } onConsume: { _ in }
    }
    
    public func stop() {
        process = nil
    }
}

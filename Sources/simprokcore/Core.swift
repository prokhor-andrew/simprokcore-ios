//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine
import simprokstate

@MainActor
public final class Core: Sendable {
    
    private let story: @Sendable () -> AnyStory
    private let machines: @Sendable () -> [AnyMachine]
    private let handlers: @Sendable () -> [MessageHandler]
    
    private var process: Process<Void, Void>?
    
    public init(
        story: @autoclosure @Sendable @escaping () -> AnyStory,
        machines: @autoclosure @Sendable @escaping () -> [AnyMachine],
        handlers: @autoclosure @Sendable @escaping () -> [MessageHandler]
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

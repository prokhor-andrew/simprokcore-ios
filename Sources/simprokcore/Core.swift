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
    private let loggers: @Sendable () -> [MachineLogger]
    
    private var process: Process<Void>?
    
    public init(
        story: @autoclosure @Sendable @escaping () -> AnyStory,
        machines: @autoclosure @Sendable @escaping () -> [AnyMachine],
        loggers: @autoclosure @Sendable @escaping () -> [MachineLogger]
    ) {
        self.story = story
        self.machines = machines
        self.loggers = loggers
    }
    
    public func start() {
        let machines = machines()
        let story = story()
        let loggers = loggers()
        
        process = Machine<Void, Void> { id in
            story.asIntTriggerIntEffect(
                SetOfMachines(Set(machines))
            )
        }.run(logger: MachineLogger { loggable in
            loggers.forEach { $0.log(loggable) }
        }) { _,_ in
            
        }
    }
    
    public func stop() {
        process?.cancel()
        process = nil
    }
}

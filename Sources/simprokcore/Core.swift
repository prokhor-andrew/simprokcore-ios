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
    
    private let machines: () -> [AnyMachine]
    private let story: () -> AnyStory
    
    private var process: Process<Void, Void>?
    
    public init(
        story: @autoclosure @escaping () -> AnyStory,
        machines: @autoclosure @escaping () -> [AnyMachine]
    ) {
        self.machines = machines
        self.story = story
    }
    
    public func start() {
        let machines = machines()
        let story = story()
        
        process = Machine {
            story.asIntTriggerIntEffect(
                SetOfMachines(Set(machines))
            )
        }.run { _ in }
    }
    
    public func stop() {
        process = nil
    }
}

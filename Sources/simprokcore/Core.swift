//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine
import simprokstate

public final class Core<Message> {
    
    private let machines: () -> [AnyMachine<Message>]
    private let story: () -> AnyStory<Message>
    
    private var process: Process<Void, Void, Message>?
    
    public init(
        story: @autoclosure @escaping () -> AnyStory<Message>,
        machines: @autoclosure @escaping () -> [AnyMachine<Message>]
    ) {
        self.machines = machines
        self.story = story
    }
    
    public func start(logger: @escaping (Message) -> Void) {
        let machines = machines()
        let story = story()
        
        process = Machine { 
            story.asIntTriggerIntEffect(
                SetOfMachines(Set(machines))
            )
        }.run { _ in } logger: { logger($0) }

    }
    
    public func stop() {
        process = nil
    }
}

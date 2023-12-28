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
public final class Core<State: Sendable, Event: Sendable>: Sendable {
    
    private let story: @Sendable () -> Story<State, Event>
    private let machines: @Sendable () -> Set<Machine<(State, Event), Event>>
    private let loggers: @Sendable () -> [MachineLogger]
    
    private var process: Process<Void>?
    
    public init(
        story: @autoclosure @Sendable @escaping () -> Story<State, Event>,
        machines: @autoclosure @Sendable @escaping () -> Set<Machine<(State, Event), Event>>,
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
        
        process = Machine<Void, Void> { _,_ -> Feature<State, Event, (State, Event), Void, Void> in
            @Sendable
            func scene(_ story: Story<State, Event>) -> Scene<State, Event, (State, Event)> {
                Scene(payload: story.payload) { extras, trigger in
                    if let newStory = story.transit(trigger, extras.machineId, extras.logger) {
                        SceneTransition(
                            scene(newStory),
                            effects: [(newStory.payload, trigger)]
                        )
                    } else {
                        SceneTransition(scene(story))
                    }
                }
            }
            
            return scene(story).asIntTriggerIntEffect(machines)
        }.run(logger: MachineLogger { loggable in
            loggers.forEach { logger in logger.log(loggable) }
        }) { _ in
            
        }
    }
    
    public func stop() {
        process?.cancel()
        process = nil
    }
}


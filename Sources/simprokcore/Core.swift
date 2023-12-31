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
public final class Core<State: Sendable, Event: Sendable, Loggable: Sendable>: Sendable {
    
    private let story: @Sendable () -> Story<State, Event, Loggable>
    private let machines: @Sendable () -> Set<Machine<(State, Event), Event, Loggable>>
    private let loggers: @Sendable () -> [MachineLogger<Loggable>]
    
    private var process: Process<Void>?
    
    public init(
        story: @autoclosure @Sendable @escaping () -> Story<State, Event, Loggable>,
        machines: @autoclosure @Sendable @escaping () -> Set<Machine<(State, Event), Event, Loggable>>,
        loggers: @autoclosure @Sendable @escaping () -> [MachineLogger<Loggable>]
    ) {
        self.story = story
        self.machines = machines
        self.loggers = loggers
    }
    
    public func start() {
        let machines = machines()
        let story = story()
        let loggers = loggers()
        
        process = Machine<Void, Void, Loggable> { _,_ -> Feature<State, Event, (State, Event), Void, Void, Loggable> in
            @Sendable
            func scene(_ story: Story<State, Event, Loggable>) -> Scene<State, Event, (State, Event), Loggable> {
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


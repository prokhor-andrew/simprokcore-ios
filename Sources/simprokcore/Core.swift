//
//  Core.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine
import simprokstate

public final class Core<AppEvent> {
    
    private let sources: () -> Sources<AppEvent>
    private let story: () -> Story<AppEvent>
    
    private var process: Process<Void, Void>?
    
    public init(
        sources: @autoclosure @escaping () -> Sources<AppEvent>,
        story: @autoclosure @escaping () -> Story<AppEvent>
    ) {
        self.sources = sources
        self.story = story
    }
    
    public func start() {
        let sources = sources()
        let story = story()
        
        process = Machine {
            story.asIntTriggerIntEffect(
                SetOfMachines(Set(sources.sources.map { $0.machine }))
            )
        }.run { _ in }
    }
    
    public func stop() {
        process = nil
    }
}

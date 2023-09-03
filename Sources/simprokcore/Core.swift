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
    
    private let plugins: () -> [Plugin]
    private let story: () -> Story<AnyStoryEvent>
    
    private var process: Process<Void, Void>?
    
    public init(
        _ story: @autoclosure @escaping () -> Story<AnyStoryEvent>,
        @PluginsBuilder plugins: @escaping () -> [Plugin]
    ) {
        self.plugins = plugins
        self.story = story
    }
    
    public func start() {
        let plugins = plugins()
        let story = story()
        
        process = Machine {
            story.asIntTriggerIntEffect(
                SetOfMachines(Set(plugins.map { $0.machine }))
            )
        }.run { _ in }
    }
    
    public func stop() {
        process = nil
    }
}

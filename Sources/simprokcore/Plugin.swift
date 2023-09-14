//
//  Plugin.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine
import simprokstate

public struct Plugin: Sendable {
    
    internal let machine: Machine<AnyStoryEvent, AnyStoryEvent>
    
    public init<Input, Output>(
        _ machine: Machine<Input, Output>,
        @PluginBuilder<Input, Output> build: () -> [Gateway<Input, Output>]
    ) {
        let gateways = build()
        
        self.machine = machine
            .outward { output in
                gateways.flatMap { $0.mapOutput(output) }
            }
            .inward { input in
                gateways.flatMap { $0.mapInput(input) }
            }
    }
}

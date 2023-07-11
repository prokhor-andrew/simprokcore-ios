//
//  Source.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine

public struct Source<AppEvent> {
    
    internal let machine: Machine<AppEvent, AppEvent>
    
    public init<Input, Output>(
        _ machine: Machine<Input, Output>,
        @SourceBuilder<AppEvent, Input, Output> build: () -> [Gateway<AppEvent, Input, Output>]
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

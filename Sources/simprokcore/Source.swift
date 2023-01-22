//
//  Source.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine
import simprokstate


public struct Source<AppEvent> {
    
    internal let machine: ParentMachine<AppEvent, AppEvent>
    
    public init<Child: Automaton>(
        _ machine: Child,
        @SourceBuilder<AppEvent, Child.Input, Child.Output> build: Supplier<[Gateway<AppEvent, Child.Input, Child.Output>]>
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

//
//  ModuleObject.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine


public struct ModuleObject<AppEvent, Child: Automaton>: ModuleProtocol {
    public typealias AppEvent = AppEvent
    public typealias Child = Child
    
    public let machine: Child
    public let gateways: Gateways<AppEvent, Child.Input, Child.Output>
    
    
    public init(machine: Child, gateways: Gateways<AppEvent, Child.Input, Child.Output>) {
        self.machine = machine
        self.gateways = gateways
    }
    
    public init(
        _ machine: Child,
        @GatewaysBuilder<AppEvent, Child.Input, Child.Output> build: Supplier<[Gateway<AppEvent, Child.Input, Child.Output>]>
    ) {
        self.init(machine: machine, gateways: Gateways(build))
    }
}

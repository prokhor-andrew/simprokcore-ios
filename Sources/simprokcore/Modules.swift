//
//  Modules.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine


public struct Modules<AppEvent> {
 
    internal let machines: [ParentMachine<AppEvent, AppEvent>]
    
    public init(@ModulesBuilder<AppEvent> _ build: Supplier<[ParentMachine<AppEvent, AppEvent>]>) {
        self.machines = build()
    }
    
    public init(_ array: [ParentMachine<AppEvent, AppEvent>]) {
        self.machines = array
    }
}

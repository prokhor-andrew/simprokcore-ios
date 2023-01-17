//
//  Gateways.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine


public struct Gateways<AppEvent, Input, Output> {
    
    internal let array: [Gateway<AppEvent, Input, Output>]
    
    public init(@GatewaysBuilder<AppEvent, Input, Output> _ build: Supplier<[Gateway<AppEvent, Input, Output>]>) {
        self.init(build())
    }
    
    public init(_ gateways: [Gateway<AppEvent, Input, Output>]) {
        self.array = gateways
    }
}

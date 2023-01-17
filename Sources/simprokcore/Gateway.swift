//
//  Gateway.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine


public struct Gateway<AppEvent, Input, Output> {

    internal let mapInput: Mapper<AppEvent, [Input]>
    internal let mapOutput: Mapper<Output, [AppEvent]>

    private init(
        mapInput: @escaping Mapper<AppEvent, [Input]>,
        mapOutput: @escaping Mapper<Output, [AppEvent]>
    ) {
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
    
    public init<M: GateProtocol>(_ gate: M) where M.Input == Input, M.Output == Output, M.Feature.AppEvent == AppEvent {
        self.init(
            mapInput: {
                if let event = M.Feature.init(event: $0) {
                    return gate.mapInput(event)
                } else {
                    return []
                }
            },
            mapOutput: { gate.mapOutput($0).compactMap { $0.event } }
        )
    }
}

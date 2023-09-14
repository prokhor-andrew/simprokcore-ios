//
//  Gateway.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokstate


public struct Gateway<Input, Output>: Sendable {

    internal let mapInput: @Sendable (AnyStoryEvent) -> [Input]
    internal let mapOutput: @Sendable (Output) -> [AnyStoryEvent]

    internal init(
        mapInput: @escaping @Sendable (AnyStoryEvent) -> [Input],
        mapOutput: @escaping @Sendable (Output) -> [AnyStoryEvent]
    ) {
        
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
}

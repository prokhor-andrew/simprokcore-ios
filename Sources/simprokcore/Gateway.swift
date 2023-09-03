//
//  Gateway.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokstate


public struct Gateway<Input, Output> {

    internal let mapInput: (AnyStoryEvent) -> [Input]
    internal let mapOutput: (Output) -> [AnyStoryEvent]

    internal init(
        mapInput: @escaping (AnyStoryEvent) -> [Input],
        mapOutput: @escaping (Output) -> [AnyStoryEvent]
    ) {
        
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
}

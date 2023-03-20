//
//  MachineGate.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine

public struct MachineGate<Feature, Input, Output> {
    
    public let mapInput: Mapper<Feature, [Input]>
    public let mapOutput: Mapper<Output, [Feature]>
    
    public init(
        mapInput: @escaping Mapper<Feature, [Input]>,
        mapOutput: @escaping Mapper<Output, [Feature]>
    ) {
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
}

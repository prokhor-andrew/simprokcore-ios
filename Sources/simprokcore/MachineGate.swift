//
//  MachineGate.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

public struct MachineGate<Feature, Input, Output> {
    
    public let mapInput: (Feature) -> [Input]
    public let mapOutput: (Output) -> [Feature]
    
    public init(
        mapInput: @escaping (Feature) -> [Input],
        mapOutput: @escaping (Output) -> [Feature]
    ) {
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
}

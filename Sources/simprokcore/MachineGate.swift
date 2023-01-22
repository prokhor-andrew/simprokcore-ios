//
//  MachineGate.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine

public struct MachineGate<Feature, Input, Output> {
    
    private let _mapInput: Mapper<Feature, [Input]>
    private let _mapOutput: Mapper<Output, [Feature]>
    
    public init(
        mapInput: @escaping Mapper<Feature, [Input]>,
        mapOutput: @escaping Mapper<Output, [Feature]>
    ) {
        self._mapInput = mapInput
        self._mapOutput = mapOutput
    }
    
    public func mapInput(_ input: Feature) -> [Input] {
        _mapInput(input)
    }
    
    public func mapOutput(_ output: Output) -> [Feature] {
        _mapOutput(output)
    }
}

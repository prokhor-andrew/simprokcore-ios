//
//  CoreGate.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine

public struct CoreGate<AppEvent, Feature> {
    
    public let mapInput: Mapper<AppEvent, Feature?>
    public let mapOutput: Mapper<Feature, AppEvent?>
    
    public init(
        mapInput: @escaping Mapper<AppEvent, Feature?>,
        mapOutput: @escaping Mapper<Feature, AppEvent?>
    ) {
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
}

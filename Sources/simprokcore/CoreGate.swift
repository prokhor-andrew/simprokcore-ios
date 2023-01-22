//
//  CoreGate.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine

public struct CoreGate<AppEvent, Feature> {
    
    private let _mapInput: Mapper<AppEvent, Feature?>
    private let _mapOutput: Mapper<Feature, AppEvent?>
    
    public init(
        mapInput: @escaping Mapper<AppEvent, Feature?>,
        mapOutput: @escaping Mapper<Feature, AppEvent?>
    ) {
        self._mapInput = mapInput
        self._mapOutput = mapOutput
    }
    
    public func mapInput(_ event: AppEvent) -> Feature? {
        _mapInput(event)
    }
    
    
    public func mapOutput(_ feature: Feature) -> AppEvent? {
        _mapOutput(feature)
    }
}

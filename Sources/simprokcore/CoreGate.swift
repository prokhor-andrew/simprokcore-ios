//
//  CoreGate.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

public struct CoreGate<AppEvent, Feature> {
    
    public let mapInput: (AppEvent) -> Feature?
    public let mapOutput: (Feature) -> AppEvent?
    
    public init(
        mapInput: @escaping (AppEvent) -> Feature?,
        mapOutput: @escaping (Feature) -> AppEvent?
    ) {
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
}

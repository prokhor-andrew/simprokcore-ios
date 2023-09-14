//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 02.09.2023.
//

import simprokstate

public struct Gate<Feature: AnyStoryEvent, Input, Output>: Sendable {

    private let mapInput: @Sendable (Feature) -> [Input]
    private let mapOutput: @Sendable (Output) -> [Feature]
    
    public init(
        mapInput: @escaping @Sendable (Feature) -> [Input],
        mapOutput: @escaping @Sendable (Output) -> [Feature]
    ) {
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
    
    public func erase() -> Gateway<Input, Output> {
        Gateway(
            mapInput: { input in
                if let input = input as? Feature {
                    return mapInput(input)
                } else {
                    return []
                }
            },
            mapOutput: mapOutput 
        )
    }
}


prefix operator ^

public prefix func ^<Feature, Input, Output>(
    gate: Gate<Feature, Input, Output>
) -> Gateway<Input, Output> {
    gate.erase()
}


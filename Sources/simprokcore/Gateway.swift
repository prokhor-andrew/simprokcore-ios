//
//  Gateway.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine


public struct Gateway<AppEvent, Input, Output> {

    public let mapInput: Mapper<AppEvent, [Input]>
    public let mapOutput: Mapper<Output, [AppEvent]>

    public init(
        mapInput: @escaping Mapper<AppEvent, [Input]>,
        mapOutput: @escaping Mapper<Output, [AppEvent]>
    ) {
        self.mapInput = mapInput
        self.mapOutput = mapOutput
    }
    
    public init<F>(_ coreGate: CoreGate<AppEvent, F>, _ machineGate: MachineGate<F, Input, Output>) {
        mapInput = {
            if let result = coreGate.mapInput($0)  {
                return machineGate.mapInput(result)
            } else {
                return []
            }
        }
        mapOutput = {
            machineGate.mapOutput($0).flatMap {
                if let result = coreGate.mapOutput($0) {
                    return [result]
                } else {
                    return []
                }
            }
        }
    }
}

prefix operator ^

public prefix func ^<F: CoreGateProvider, Input, Output>(
        machineGate: MachineGate<F, Input, Output>
) -> Gateway<F.Event, Input, Output> {
    Gateway(F.gate, machineGate)
}

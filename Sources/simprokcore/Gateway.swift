//
//  Gateway.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine


public struct Gateway<AppEvent, Input, Output> {

    internal let mapInput: Mapper<AppEvent, [Input]>
    internal let mapOutput: Mapper<Output, [AppEvent]>

    internal init<F>(_ machineGate: MachineGate<F, Input, Output>, _ coreGate: CoreGate<AppEvent, F>) {
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


infix operator &

public func &<F, AppEvent, Input, Output>(lhs: MachineGate<F, Input, Output>, rhs: CoreGate<AppEvent, F>) -> Gateway<AppEvent, Input, Output> {
    Gateway(lhs, rhs)
}

public func &<F, AppEvent, Input, Output>(lhs: CoreGate<AppEvent, F>, rhs: MachineGate<F, Input, Output>) -> Gateway<AppEvent, Input, Output> {
    rhs & lhs
}

prefix operator ^

public prefix func ^<F: CoreGateProvider, Input, Output>(
        machineGate: MachineGate<F, Input, Output>
) -> Gateway<F.Event, Input, Output> {
    Gateway(machineGate, F.gate)
}
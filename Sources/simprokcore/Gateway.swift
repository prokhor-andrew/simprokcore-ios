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
        self.mapInput = {
            coreGate.mapInput($0).flatMap { machineGate.mapInput($0) }
        }
        self.mapOutput = {
            machineGate.mapOutput($0).flatMap { coreGate.mapOutput($0) }
        }
    }
}


infix operator &
public func & <F, AppEvent, Input, Output>(lhs: MachineGate<F, Input, Output>, rhs: CoreGate<AppEvent, F>) -> Gateway<AppEvent, Input, Output> {
    Gateway(lhs, rhs)
}

public func & <F, AppEvent, Input, Output>(lhs: CoreGate<AppEvent, F>, rhs: MachineGate<F, Input, Output>) -> Gateway<AppEvent, Input, Output> {
    rhs & lhs
}

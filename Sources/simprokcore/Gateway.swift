//
//  Gateway.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct Gateway<AppEvent, Input, Output> {

    public let inward: Mapper<AppEvent, [Input]>
    public let outward: Mapper<Output, [AppEvent]>

    public init(
        inward: @escaping Mapper<AppEvent, [Input]>,
        outward: @escaping Mapper<Output, [AppEvent]>
    ) {
        self.inward = inward
        self.outward = outward
    }

    public init<CG: CoreGate, MG: MachineGate>(core: CG, machine: MG) where CG.Feature == MG.Feature, CG.AppEvent == AppEvent, MG.Input == Input, MG.Output == Output {
        self.inward = { core.inward($0).flatMap { value in machine.inward(value) } }
        self.outward = { machine.outward($0).flatMap { value in core.outward(value) } }
    }
}


public func +<CG: CoreGate, MG: MachineGate>(lhs: CG, rhs: MG) -> Gateway<CG.AppEvent, MG.Input, MG.Output> where CG.Feature == MG.Feature {
    Gateway(core: lhs, machine: rhs)
}

public func +<CG: CoreGate, MG: MachineGate>(lhs: MG, rhs: CG) -> Gateway<CG.AppEvent, MG.Input, MG.Output> where CG.Feature == MG.Feature {
    rhs + lhs
}

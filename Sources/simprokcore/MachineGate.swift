//
//  MachineGate.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//


public protocol MachineGate {
    associatedtype Feature
    associatedtype Input
    associatedtype Output

    func inward(_ input: Feature) -> [Input]

    func outward(_ output: Output) -> [Feature]
}

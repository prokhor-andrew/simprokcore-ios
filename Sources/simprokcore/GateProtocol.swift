//
//  GateProtocol.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

public protocol GateProtocol {
    associatedtype Feature: CoreEvent
    associatedtype Input
    associatedtype Output

    func mapInput(_ input: Feature) -> [Input]

    func mapOutput(_ output: Output) -> [Feature]
}

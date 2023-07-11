//
//  CoreGateProvider.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

public protocol CoreGateProvider {
    associatedtype Event

    static var gate: CoreGate<Event, Self> { get }
}

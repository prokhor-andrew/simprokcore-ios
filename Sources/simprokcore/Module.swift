//
//  Module.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol Module {
    associatedtype AppEvent
    associatedtype Child: Automaton

    var machine: Child { get }
    
    var gateways: Gateways<AppEvent, Child.Input, Child.Output> { get }
}

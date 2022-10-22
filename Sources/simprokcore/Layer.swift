//
//  Layer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general structure that describes a type that represents a layer object.
public struct Layer<Event>: LayerType {
    
    public let machine: Machine<Event, Event>
    
    public init<L: LayerType>(_ layer: L) where L.Event == Event {
        self.machine = layer.machine
    }
    
    public init<M: MachineType>(_ machine: M) where M.Input == Event, M.Output == Event {
        self.machine = ~machine
    }
}

//
//  State.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import Foundation


public struct State<Event> {
    
    public let id: String
    public let transit: Mapper<Event, Transition<Event>>
    
    public init(id: String, transit: @escaping Mapper<Event, Transition<Event>>) {
        self.id = id
        self.transit = transit
    }
    
    public init(transit: @escaping Mapper<Event, Transition<Event>>) {
        self.init(id: UUID().uuidString, transit: transit)
    }
    
    public func id(_ id: String) -> State<Event> {
        .init(id: id, transit: transit)
    }
}

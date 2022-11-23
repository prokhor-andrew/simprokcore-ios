//
//  Feature.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.



public protocol Feature {
    associatedtype Event
    
    func scenario() -> State<Event>
}


extension State: Feature {
    
    public func scenario() -> State<Event> { self }
}

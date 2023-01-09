//
//  CoreGate.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved. Created by Andriy Prokhorenko on 09.01.2023.
//


public protocol CoreGate {
    associatedtype AppEvent
    associatedtype Feature
    
    func inward(_ input: AppEvent) -> [Feature]
    
    func outward(_ output: Feature) -> [AppEvent]
}

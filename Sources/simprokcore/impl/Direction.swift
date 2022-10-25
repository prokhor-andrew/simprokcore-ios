//
//  Direction.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import Foundation


// a copy from tools in order to remove dependency
internal enum Direction<Input> {
    case prop
    case back([Input])
    
    internal static func back(_ values: Input...) -> Direction<Input> {
        .back(values)
    }
}

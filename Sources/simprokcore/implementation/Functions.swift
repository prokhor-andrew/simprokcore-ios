//
//  Functions.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


extension Array {
    
    func copy(add element: Element) -> Self {
        var copied = self
        copied.append(element)
        return copied
    }
}

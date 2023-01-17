//
//  Array+Copy.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


internal extension Array {
    
    func copy(add value: Element) -> Array<Element> {
        var copied = self
        copied.append(value)
        return copied
    }
}

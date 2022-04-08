//
//  UserDefaults+Machine.swift
//  sample
//
//  Created by Andrey Prokhorenko on 19.02.2022.
//

import simprokmachine
import Foundation


extension UserDefaults: ChildMachine {
    public typealias Input = StorageLayerState
    public typealias Output = StorageLayerEvent
    
    public var queue: MachineQueue { .main }
    
    private var key: String { "storage" }
    
    public func process(input: Input?, callback: @escaping Handler<Output>) {
        if let input = input {
            set(input.value, forKey: key)
        } else {
            callback(.init(integer(forKey: key)))
        }
    }
}

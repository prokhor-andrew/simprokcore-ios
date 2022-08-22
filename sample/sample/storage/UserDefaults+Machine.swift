//
//  UserDefaults+Machine.swift
//  sample
//
//  Created by Andrey Prokhorenko on 19.02.2022.
//

import simprokmachine
import Foundation


extension UserDefaults: ChildMachine {
    public typealias Input = StorageLayerInput
    public typealias Output = StorageLayerOutput
    
    public var queue: MachineQueue { .main }
    
    private var key: String { "storage" }
    
    public func process(input: Input?, callback: @escaping Handler<Output>) {
        if input != nil {
            // nothing
        } else {
            callback(.init(self.integer(forKey: key)))
        }
    }
}

//
//  LoggerMachine.swift
//  sample
//
//  Created by Andrey Prokhorenko on 30.05.2022.
//

import Foundation
import simprokmachine


final class LoggerMachine: ChildMachine {
    typealias Input = String
    typealias Output = Void
    
    var queue: MachineQueue { .main }
    
    func process(input: Input?, callback: @escaping Handler<Output>) {
        print("\(input ?? "loading")")
    }
}

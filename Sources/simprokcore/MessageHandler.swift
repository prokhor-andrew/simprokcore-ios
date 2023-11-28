//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 27.11.2023.
//

import simprokmachine

public struct MessageHandler {
    
    public let handler: (Loggable) -> Void
    
    public init<Object>(_ object: Object, handler: @escaping (Object, Loggable) -> Void) {
        self.handler = { handler(object, $0) }
    }
    
    public init(handler: @escaping (Loggable) -> Void) {
        self.handler = handler
    }
}

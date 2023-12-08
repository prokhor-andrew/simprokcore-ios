//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 27.11.2023.
//

import simprokmachine

public struct MessageHandler: Sendable {
    
    public let handler: @Sendable (Loggable) -> Void
    
    public init<Object: Sendable>(_ object: Object, handler: @escaping @Sendable (Object, Loggable) -> Void) {
        self.handler = { handler(object, $0) }
    }
    
    public init(handler: @escaping @Sendable (Loggable) -> Void) {
        self.handler = handler
    }
}

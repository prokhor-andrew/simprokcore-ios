//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 27.11.2023.
//

public struct MessageHandler<Message> {
    
    public let handler: (Message) -> Void
    
    public init<Object>(_ object: Object, handler: @escaping (Object, Message) -> Void) {
        self.handler = { handler(object, $0) }
    }
    
    public init(handler: @escaping (Message) -> Void) {
        self.handler = handler
    }
}

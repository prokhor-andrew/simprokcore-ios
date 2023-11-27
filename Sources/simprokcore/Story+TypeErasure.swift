//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 29.08.2023.
//

import simprokstate

public extension Story where Event: AnyEvent {
    
    func erase() -> AnyStory<Message> {
        AnyStory { event, logger in
            if let casted = event as? Event {
                return transit(casted, logger)?.erase()
            } else {
                return nil
            }
        }
    }
}

prefix operator ^

public prefix func ^<Event: AnyEvent, Message>(
    story: Story<Event, Message>
) -> AnyStory<Message> {
    story.erase()
}

//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 29.08.2023.
//

import simprokstate

public extension Story where Event: AnyEvent {
    
    func erase() -> AnyStory {
        if let transit {
            return AnyStory.create { event in
                if let casted = event as? Event {
                    return transit(casted)?.erase()
                } else {
                    return nil
                }
            }
        } else {
            return .finale()
        }
    }
}

prefix operator ^

public prefix func ^<Event: AnyEvent>(
    story: Story<Event>
) -> AnyStory {
    story.erase()
}

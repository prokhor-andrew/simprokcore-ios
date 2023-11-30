//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 29.08.2023.
//

import simprokstate

public extension Story where Event: AnyEvent {
    
    func erase() -> AnyStory {
        AnyStory { extras, event in
            if let casted = event as? Event {
                return transit(casted, extras.machineId, extras.logger)?.erase()
            } else {
                return nil
            }
        }
    }
}

prefix operator ^

public prefix func ^<Event: AnyEvent>(
    story: Story<Event>
) -> AnyStory {
    story.erase()
}

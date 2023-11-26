//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 22.11.2023.
//

import simprokstate


internal extension Story {
    
    func doOn(
        update: @escaping (Event, Bool, (String) -> Void) -> Void
    ) -> Story<Event> {
        Story { event, logger in
            let new = transit(event, logger)
            
            update(event, new == nil, logger)
            
            return new?.doOn(update: update)
        }
    }
}

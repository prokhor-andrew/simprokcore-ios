//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 22.11.2023.
//

import simprokstate


internal extension Story {
    
    func doOn(
        update: @escaping (Event, Bool) -> Void
    ) -> Story<Event> {
        if let transit {
            return Story<Event>.create { event in
                let new = transit(event)
                
                update(event, new == nil)
                
                return new?.doOn(update: update)
            }
        } else {
            return .finale()
        }
    }
}

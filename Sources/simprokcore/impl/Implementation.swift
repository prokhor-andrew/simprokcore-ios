import Foundation
import simprokstate
import simprokmachine

fileprivate let queue = DispatchQueue(label: "multicorequeue", qos: .userInteractive)
fileprivate var subscriptions: [ObjectIdentifier: AnyObject] = [:]

internal func _start<AppEvent>(
        sender: AnyObject,
        story: Story<AppEvent>,
        sources: Sources<AppEvent>
) {
    queue.sync {
        // check if there is already a subscription for this Core

        if subscriptions[ObjectIdentifier(sender)] != nil {
            return
        }

        let feature: Feature<AppEvent, AppEvent, Void, Void> = story.asIntTriggerIntEffect(
            SetOfMachines(Set(sources.sources.map {
                $0.machine
            }))
        )
        
        subscriptions[ObjectIdentifier(sender)] = Machine(FeatureTransition(feature)).started { _, _ in }
    }
}

internal func _stop(_ sender: AnyObject) {
    queue.sync {
        _ = subscriptions.removeValue(forKey: ObjectIdentifier(sender))
    }
}

fileprivate extension Story {

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Event, ExtTrigger, ExtEffect> where Machines.Trigger == Event, Machines.Effect == Event {
        if let transit {
            return Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return nil
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asIntTriggerIntEffect(machines),
                                effects: .int(value)
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale(machines)
        }
    }
}

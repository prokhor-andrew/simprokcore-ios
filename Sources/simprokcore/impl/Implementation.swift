import simprokstate
import simprokmachine

fileprivate var subscriptions: [ObjectIdentifier: AnyObject] = [:]

internal func _start<AppEvent>(
        sender: AnyObject,
        story: Story<AppEvent>,
        sources: Sources<AppEvent>
) {
    // check if there is already a subscription for this Core

    if subscriptions[ObjectIdentifier(sender)] != nil {
        return
    }

    let feature: Feature<AppEvent, AppEvent, Void, Void> = IntTriggerIntEffect(
            story,
            machines: sources.sources.map { $0.machine }
    )

    subscriptions[ObjectIdentifier(sender)] = Machine(Feature.Transition(feature)).subscribe { _, _ in }
}

internal func _stop(_ sender: AnyObject) {
    subscriptions.removeValue(forKey: ObjectIdentifier(sender))
}

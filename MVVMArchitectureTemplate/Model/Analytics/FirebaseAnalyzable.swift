import FirebaseAnalytics

/// @mockable
protocol FirebaseAnalyzable {
    var screenId: FAScreenId { get }

    func sendEvent(_ name: String, parameters: [String: Any])
    func sendEvent(_ event: FAEvent)
}

extension FirebaseAnalyzable {
    func sendEvent(_ name: String, parameters: [String: Any]) {
        let params = parameters.mapValues {
            $0 is String
                ? ($0 as! String).prefix(100)
                : $0
        }

        Analytics.logEvent(name, parameters: params)
    }

    func sendEvent(_ event: FAEvent) {
        var parameters = event.parameter
        parameters[FAParameter.screenId.rawValue] = screenId.rawValue
        sendEvent(event.name, parameters: parameters)
    }
}

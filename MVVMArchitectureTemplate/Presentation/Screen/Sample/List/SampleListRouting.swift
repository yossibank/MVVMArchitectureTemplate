import UIKit

final class SampleListRouting: RoutingObject {
    weak var viewController: UIViewController?

    func showAddScreen() {
        viewController?.navigationController?.pushViewController(
            AppControllers.Sample.Add(),
            animated: true
        )
    }

    func showDetailScreen(_ modelObject: SampleModelObject) {
        viewController?.navigationController?.pushViewController(
            AppControllers.Sample.Detail(modelObject),
            animated: true
        )
    }
}

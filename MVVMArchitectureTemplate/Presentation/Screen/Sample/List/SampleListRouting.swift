import UIKit

final class SampleListRouting: RoutingObject {
    weak var viewController: UIViewController!

    func showDetailScreen(_ modelObject: SampleModelObject) {
        viewController.navigationController?.pushViewController(
            AppControllers.Sample.Detail(modelObject),
            animated: true
        )
    }
}

import UIKit

final class SampleDetailRouting: RoutingObject {
    weak var viewController: UIViewController?

    func showEditScreen(modelObject: SampleModelObject) {
        viewController?.present(
            AppControllers.Sample.Edit(modelObject),
            animated: true
        )
    }
}

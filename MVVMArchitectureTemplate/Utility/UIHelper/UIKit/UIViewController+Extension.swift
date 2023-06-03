import SnapKit
import SwiftUI
import UIKit

extension UIViewController {
    func addChild(_ childView: some SwiftUI.View) {
        let hostingVC = UIHostingController(rootView: childView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)

        hostingVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        hostingVC.didMove(toParent: self)
    }
}

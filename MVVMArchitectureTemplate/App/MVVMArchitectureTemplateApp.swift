import Firebase
import SwiftUI

@main
struct MVVMArchitectureTemplateApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SampleListView()
        }
    }
}

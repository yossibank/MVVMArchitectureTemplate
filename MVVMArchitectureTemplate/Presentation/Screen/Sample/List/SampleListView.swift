import SwiftUI

struct SampleListView: View {
    @StateObject private var viewModel = SampleListSwiftUIViewModel(model: Models.Sample())

    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {
        List(viewModel.output.modelObjects, id: \.self) {
            SampleRow(modelObject: $0)
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.input.viewDidLoad.send(())
        }
    }
}

struct SampleListView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListView()
    }
}

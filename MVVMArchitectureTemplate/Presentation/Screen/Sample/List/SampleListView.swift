import SwiftUI

struct SampleListView: View {
    @StateObject private var viewModel = ViewModels.Sample.List()

    var body: some View {
        NavigationView {
            List(viewModel.output.modelObjects, id: \.self) {
                SampleRow(modelObject: $0)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
            }
            .navigationTitle("サンプル一覧")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .onAppear {
                viewModel.input.onAppear.send(())
            }
        }
    }
}

struct SampleListView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListView()
    }
}

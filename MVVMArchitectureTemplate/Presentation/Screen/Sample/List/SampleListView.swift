import SwiftUI

struct SampleListView: View {
    @StateObject private var viewModel = ViewModels.Sample.List()

    var body: some View {
        NavigationView {
            List(
                viewModel.output.isLoading
                    ? viewModel.output.placeholder
                    : viewModel.output.modelObjects,
                id: \.self
            ) {
                SampleRow(modelObject: $0)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
            }
            .listStyle(.plain)
            .redacted(showPlaceholder: viewModel.output.isLoading)
            .toolbar {
                NavigationLink(destination: viewModel.router.routeToSample()) {
                    Image(systemName: "plus.square")
                        .tint(.primary)
                }
            }
            .navigationTitle("サンプル一覧")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.input.onAppear.send(())
        }
    }
}

struct SampleListView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListView()
    }
}

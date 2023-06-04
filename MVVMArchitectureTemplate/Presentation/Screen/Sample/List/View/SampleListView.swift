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
            ) { modelObject in
                ZStack {
                    NavigationLink(destination: viewModel.router.routeToDetail(id: modelObject.id)) {
                        EmptyView()
                    }
                    .opacity(0)

                    SampleRow(modelObject: modelObject)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(.init())
            }
            .listStyle(.plain)
            .animation(.default, value: viewModel.output.modelObjects)
            .redacted(showPlaceholder: viewModel.output.isLoading)
            .toolbar {
                NavigationLink(destination: viewModel.router.routeToAdd()) {
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
        .refreshable {
            viewModel.input.pullToRefresh.send(())
        }
    }
}

struct SampleListView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListView()
    }
}

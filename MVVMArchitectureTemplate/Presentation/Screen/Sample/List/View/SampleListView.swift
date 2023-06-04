import SwiftUI

struct SampleListView: View {
    @StateObject var viewModel = ViewModels.Sample.List()

    init(viewModel: SampleListViewModel = ViewModels.Sample.List()) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            List(
                viewModel.output.isLoading
                    ? viewModel.output.placeholder
                    : viewModel.output.modelObjects,
                id: \.self
            ) { modelObject in
                ZStack {
                    NavigationLink(destination: viewModel.router.routeToDetail(modelObject: modelObject)) {
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
            .navigationTitle("サンプル一覧")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(destination: viewModel.router.routeToAdd()) {
                    Image(systemName: "plus.square")
                        .tint(.primary)
                }
            }
        }
        .onAppear {
            viewModel.input.onAppear.send(())
        }
        .refreshable {
            viewModel.input.viewRefresh.send(())
        }
        .alert(
            isPresented: viewModel.$binding.isShowErrorAlert,
            error: viewModel.output.appError
        ) {
            Button("閉じる") {}

            Button("再読み込み") {
                viewModel.input.viewRefresh.send(())
            }
        }
    }
}

struct SampleListView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListView()
    }
}

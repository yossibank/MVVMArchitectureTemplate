import SwiftUI

struct SampleListView: View {
    @StateObject var viewModel = ViewModels.Sample.List()

    init(viewModel: SampleListViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            List(viewModel.modelObjects, id: \.self) { modelObject in
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
            .animation(.default, value: viewModel.modelObjects)
            .redacted(showPlaceholder: viewModel.showPlaceholder)
            .navigationTitle("サンプル一覧")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(destination: viewModel.router.routeToAdd()) {
                    Image(systemName: "plus.square")
                        .tint(.primary)
                }
            }
        }
        .task {
            await viewModel.fetch()
        }
        .refreshable {
            await viewModel.fetch(pullToRefresh: true)
        }
        .alert(
            isPresented: $viewModel.isShowErrorAlert,
            error: viewModel.appError
        ) {
            Button("閉じる") {}

            Button("再読み込み") {
                Task {
                    await viewModel.fetch()
                }
            }
        }
    }
}

struct SampleListView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListView(viewModel: ViewModels.Sample.List())
    }
}

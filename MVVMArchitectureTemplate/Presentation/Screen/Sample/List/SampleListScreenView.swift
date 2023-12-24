import SwiftUI

struct SampleListScreenView: View {
    @StateObject var viewModel: SampleListViewModel

    init(viewModel: SampleListViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            ForEach(viewModel.state.modelObjects, id: \.self) { modelObject in
                LazyVStack {
                    SampleRow(
                        modelObject: modelObject,
                        listRowTapped: {
                            viewModel.listRowTapped(modelObject: $0)
                        }
                    )
                }
            }
        }
        .redacted(showPlaceholder: viewModel.state.showPlaceholder)
        .toolbar {
            Image(systemName: "plus.square")
                .tint(.primary)
                .ally("add_button")
                .onTapGesture {
                    viewModel.addButtonTapped()
                }
        }
        .task {
            await viewModel.fetch()
        }
        .refreshable {
            await viewModel.fetch(isPullToRefresh: true)
        }
        .alert(
            isPresented: $viewModel.state.isShowErrorAlert,
            error: viewModel.state.appError
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

struct SampleRow: View {
    var modelObject: SampleModelObject
    var listRowTapped: (SampleModelObject) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 16) {
                Text("ID: \(modelObject.id.description)")
                    .font(.system(size: 10))
                    .frame(width: 40)

                VStack(alignment: .leading, spacing: 4) {
                    Text("UserID: \(modelObject.userId.description)")
                        .font(.system(size: 10))
                        .lineLimit(1)

                    Text(modelObject.title)
                        .font(.system(size: 14, weight: .bold))
                        .lineLimit(2)

                    Text(modelObject.body)
                        .font(.system(size: 11, weight: .bold))
                        .lineLimit(1)
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

            Divider()
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            listRowTapped(modelObject)
        }
    }
}

#Preview("List") {
    SampleListScreenView(
        viewModel: SampleListViewModel(
            state: .init(),
            dependency: .init(
                model: SampleModelMock(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        )
    )
}

#Preview("Row") {
    SampleRow(
        modelObject: SampleModelObjectBuilder().build(),
        listRowTapped: { _ in }
    )
}

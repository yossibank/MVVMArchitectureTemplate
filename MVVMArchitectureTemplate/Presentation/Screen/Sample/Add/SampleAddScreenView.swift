import SwiftUI

struct SampleAddScreenView: View {
    @StateObject var viewModel: SampleAddViewModel

    @FocusState private var focusField: FocusField?

    init(viewModel: SampleAddViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("UserID: MyユーザーID")
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()

                    Text("入力文字数: \(viewModel.state.title.count)")
                        .font(.system(size: 10))
                }

                TextField(
                    "タイトル",
                    text: .init(
                        get: { viewModel.state.title },
                        set: { viewModel.state.title = $0 }
                    )
                )
                .textFieldStyle(SampleTextFieldStyle())
                .focused($focusField, equals: .title)
                .onTapGesture {
                    focusField = .title
                }

                Text(viewModel.state.titleError.description)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()

                    Text("入力文字数: \(viewModel.state.body.count)")
                        .font(.system(size: 10))
                }

                TextField(
                    "内容",
                    text: .init(
                        get: { viewModel.state.body },
                        set: { viewModel.state.body = $0 }
                    )
                )
                .textFieldStyle(SampleTextFieldStyle())
                .focused($focusField, equals: .body)
                .onTapGesture {
                    focusField = .body
                }

                Text(viewModel.state.bodyError.description)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }

            Button("作成する") {
                Task {
                    await viewModel.post()
                }
            }
            .buttonStyle(SampleButtonStyle())
            .disabled(!viewModel.state.isEnabled)
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 32)
        .navigationTitle("サンプル追加")
        .navigationBarTitleDisplayMode(.inline)
        .contentShape(Rectangle())
        .onTapGesture {
            focusField = nil
        }
        .alert(
            "成功: \(viewModel.state.successObject?.title ?? "")",
            isPresented: $viewModel.state.isShowSuccessAlert
        ) {
            Button("戻る") {
                viewModel.successAlertTapped()
            }
        }
        .alert(
            isPresented: $viewModel.state.isShowErrorAlert,
            error: viewModel.state.appError
        ) {
            Button("閉じる") {}
        }
    }
}

extension SampleAddScreenView {
    enum FocusField: Hashable {
        case title
        case body
    }
}

#Preview {
    SampleAddScreenView(
        viewModel: SampleAddViewModel(
            state: .init(),
            dependency: .init(
                model: SampleModelMock(),
                analytics: FirebaseAnalytics(screenId: .sampleAdd)
            )
        )
    )
}

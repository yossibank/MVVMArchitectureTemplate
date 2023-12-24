import SwiftUI

struct SampleEditScreenView: View {
    @StateObject var viewModel: SampleEditViewModel

    @FocusState private var focusField: FocusField?

    init(viewModel: SampleEditViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("UserID: \(viewModel.state.modelObject.userId.description)")
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()

                    Text("入力文字数: \(viewModel.state.modelObject.title.count)")
                        .font(.system(size: 10))
                }

                TextField(
                    "タイトル",
                    text: .init(
                        get: { viewModel.state.modelObject.title },
                        set: { viewModel.state.modelObject.title = $0 }
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

                    Text("入力文字数: \(viewModel.state.modelObject.body.count)")
                        .font(.system(size: 10))
                }

                TextField(
                    "内容",
                    text: .init(
                        get: { viewModel.state.modelObject.body },
                        set: { viewModel.state.modelObject.body = $0 }
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

            Button("編集する") {
                Task {
                    await viewModel.update()
                }
            }
            .buttonStyle(SampleButtonStyle())
            .disabled(!viewModel.state.isEnabled)
            .padding(.vertical, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 32)
        .backgroundColor(light: .white, dark: .black)
        .navigationTitle("サンプル編集")
        .navigationBarTitleDisplayMode(.inline)
        .contentShape(Rectangle())
        .onTapGesture {
            focusField = nil
        }
        .alert(
            "成功 \(viewModel.state.successObject?.title ?? "")",
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

extension SampleEditScreenView {
    enum FocusField: Hashable {
        case title
        case body
    }
}

#Preview {
    SampleEditScreenView(
        viewModel: SampleEditViewModel(
            state: .init(modelObject: SampleModelObjectBuilder().build()),
            dependency: .init(
                model: SampleModelMock(),
                analytics: FirebaseAnalytics(screenId: .sampleEdit)
            )
        )
    )
}

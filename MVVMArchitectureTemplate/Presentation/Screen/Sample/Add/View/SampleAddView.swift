import SwiftUI

struct SampleAddView: View {
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

                    Text("入力文字数: \(viewModel.title.count)")
                        .font(.system(size: 10))
                }

                TextField("タイトル", text: $viewModel.title)
                    .textFieldStyle(SampleTextFieldStyle())
                    .focused($focusField, equals: .title)
                    .onTapGesture {
                        focusField = .title
                    }

                Text(viewModel.titleError.description)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()

                    Text("入力文字数: \(viewModel.body.count)")
                        .font(.system(size: 10))
                }

                TextField("内容", text: $viewModel.body)
                    .textFieldStyle(SampleTextFieldStyle())
                    .focused($focusField, equals: .body)
                    .onTapGesture {
                        focusField = .body
                    }

                Text(viewModel.bodyError.description)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }

            Button("作成する") {
                Task {
                    await viewModel.post()
                }
            }
            .buttonStyle(SampleButtonStyle())
            .disabled(!viewModel.isEnabled)
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
            "成功",
            isPresented: $viewModel.isShowSuccessAlert
        ) {} message: {
            Text("タイトル: \(viewModel.modelObject?.title ?? "")")
        }
        .alert(
            isPresented: $viewModel.isShowErrorAlert,
            error: viewModel.appError
        ) {}
    }
}

extension SampleAddView {
    enum FocusField: Hashable {
        case title
        case body
    }
}

struct SampleAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SampleAddView(viewModel: ViewModels.Sample.Add())
        }
    }
}

import SwiftUI

struct SampleAddView: View {
    @StateObject var viewModel: SampleAddViewModel

    @FocusState private var focusField: FocusField?

    init(viewModel: SampleAddViewModel = ViewModels.Sample.Add()) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("UserID: MyユーザーID")
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()

                    Text("入力文字数: \(viewModel.binding.title.count)")
                        .font(.system(size: 10))
                }

                TextField("タイトル", text: viewModel.$binding.title)
                    .textFieldStyle(SampleTextFieldStyle())
                    .focused($focusField, equals: .title)
                    .onTapGesture {
                        focusField = .title
                    }

                Text(viewModel.output.titleError.description)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()

                    Text("入力文字数: \(viewModel.binding.body.count)")
                        .font(.system(size: 10))
                }

                TextField("内容", text: viewModel.$binding.body)
                    .textFieldStyle(SampleTextFieldStyle())
                    .focused($focusField, equals: .body)
                    .onTapGesture {
                        focusField = .body
                    }

                Text(viewModel.output.bodyError.description)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }

            Button("作成する") {
                viewModel.input.didTapCreateButton.send(())
            }
            .buttonStyle(SampleButtonStyle())
            .disabled(!viewModel.output.isEnabled)
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 32)
        .navigationTitle("サンプル追加")
        .navigationBarTitleDisplayMode(.inline)
        .contentShape(Rectangle())
        .onTapGesture {
            focusField = nil
        }
        .onAppear {
            viewModel.input.onAppear.send(())
        }
        .alert(
            "成功",
            isPresented: viewModel.$binding.isShowSuccessAlert
        ) {} message: {
            Text("タイトル: \(viewModel.output.modelObject?.title ?? "")")
        }
        .alert(
            isPresented: viewModel.$binding.isShowErrorAlert,
            error: viewModel.output.appError
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
            SampleAddView()
        }
    }
}

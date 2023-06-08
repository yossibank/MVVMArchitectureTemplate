import SwiftUI

struct SampleEditView: View {
    @StateObject var viewModel: SampleEditViewModel

    @FocusState private var focusField: FocusField?

    init(modelObject: SampleModelObject) {
        _viewModel = .init(wrappedValue: ViewModels.Sample.Edit(modelObject: modelObject))
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("UserID: \(viewModel.modelObject.userId.description)")
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

            Button("編集する") {
                Task {
                    await viewModel.update()
                }
            }
            .buttonStyle(SampleButtonStyle())
            .disabled(!viewModel.isEnabled)
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
            "成功",
            isPresented: $viewModel.isShowSuccessAlert
        ) {} message: {
            Text("タイトル: \(viewModel.successObject?.title ?? "")")
        }
        .alert(
            isPresented: $viewModel.isShowErrorAlert,
            error: viewModel.appError
        ) {}
    }
}

extension SampleEditView {
    enum FocusField: Hashable {
        case title
        case body
    }
}

struct SampleEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SampleEditView(modelObject: SampleModelObjectBuilder().build())
        }
    }
}

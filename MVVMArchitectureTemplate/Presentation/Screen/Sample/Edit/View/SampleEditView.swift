import SwiftUI

struct SampleEditView: View {
    @StateObject var viewModel: SampleEditSwiftUIViewModel

    @FocusState private var focusField: FocusField?

    init(modelObject: SampleModelObject) {
        _viewModel = .init(wrappedValue: ViewModels.Sample.Edit(modelObject: modelObject))
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("UserID: \(viewModel.output.initialModelObject?.userId.description ?? "")")
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

            Button("編集する") {
                viewModel.input.didTapEditButton.send(())
            }
            .buttonStyle(SampleButtonStyle())
            .disabled(!viewModel.output.isEnabled)
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
        .onAppear {
            viewModel.input.onAppear.send(())
        }
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
        SampleEditView(modelObject: SampleModelObjectBuilder().build())
    }
}

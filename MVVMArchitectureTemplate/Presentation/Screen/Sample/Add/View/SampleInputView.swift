import SwiftUI

enum InputType: String {
    case title = "タイトル"
    case body = "内容"

    var validCountText: String {
        switch self {
        case .title:
            return 15.description

        case .body:
            return 30.description
        }
    }
}

struct SampleInputView: View {
    @ObservedObject var viewModel: SampleAddViewModel

    var inputType: InputType

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .trailing) {
                Text("入力文字数: \(countText(inputType: inputType))")
                    .font(.caption2)
                    .padding(.trailing)

                TextField(inputType.rawValue, text: bindingText(inputType: inputType))
                    .textFieldStyle(SampleTextFieldStyle())
                    .autocorrectionDisabled()
            }

            if !isEnabled(inputType: inputType) {
                Text("\(inputType.rawValue)が長すぎます。\(inputType.validCountText)文字以内で入力してください。")
                    .invalid()
                    .padding(.leading)
            }
        }
        .frame(height: 80, alignment: .top)
        .padding()
    }

    private func countText(inputType: InputType) -> String {
        switch inputType {
        case .title:
            return viewModel.binding.title.count.description

        case .body:
            return viewModel.binding.body.count.description
        }
    }

    private func bindingText(inputType: InputType) -> Binding<String> {
        switch inputType {
        case .title:
            return viewModel.$binding.title

        case .body:
            return viewModel.$binding.body
        }
    }

    private func isEnabled(inputType: InputType) -> Bool {
        switch inputType {
        case .title:
            return viewModel.output.isEnabledTitle

        case .body:
            return viewModel.output.isEnabledBody
        }
    }
}

struct SampleInputView_Previews: PreviewProvider {
    static var previews: some View {
        SampleInputView(
            viewModel: ViewModels.Sample.Add(),
            inputType: .title
        )
    }
}

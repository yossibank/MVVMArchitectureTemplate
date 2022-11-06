import SwiftUI

struct SampleAddView: View {
    @StateObject var viewModel = ViewModels.Sample.Add()

    var body: some View {
        VStack(spacing: 32) {
            Text("ユーザーID: 777")
                .foregroundColor(.blue)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.blue)
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)

            SampleInputView(
                viewModel: viewModel,
                inputType: .title
            )

            SampleInputView(
                viewModel: viewModel,
                inputType: .body
            )

            Button("サンプル作成") {
                viewModel.input.addButtonTapped.send(())
            }
            .buttonStyle(SampleButtonStyle())
        }
        .padding([.leading, .trailing])
    }
}

struct SampleAddView_Previews: PreviewProvider {
    static var previews: some View {
        SampleAddView(viewModel: ViewModels.Sample.Add())
    }
}

import SwiftUI

struct SampleAddView: View {
    @StateObject var viewModel = ViewModels.Sample.Add()

    @Environment(\.presentationMode) var mode

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
                .padding(.leading, 16)

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
        .padding(.horizontal, 16)
        .alert(isPresented: viewModel.$binding.isCompleted) {
            Alert(
                title: Text("サンプル作成完了"),
                message: Text("タイトル名「\(viewModel.output.modelObject?.title ?? "???")」が登録されます"),
                dismissButton: .default(Text("閉じる")) {
                    mode.wrappedValue.dismiss()
                }
            )
        }
        .onViewWillAppear {
            viewModel.input.viewWillAppear.send(())
        }
    }
}

struct SampleAddView_Previews: PreviewProvider {
    static var previews: some View {
        SampleAddView(viewModel: ViewModels.Sample.Add())
    }
}

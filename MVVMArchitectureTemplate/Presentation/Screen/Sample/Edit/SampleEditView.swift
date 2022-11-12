import SwiftUI

struct SampleEditView: View {
    @ObservedObject var viewModel: SampleEditViewModel

    @Environment(\.presentationMode) var mode

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 32) {
                TextField("", text: viewModel.$binding.title)
                    .textFieldStyle(SampleTextFieldStyle())

                TextField("", text: viewModel.$binding.body)
                    .textFieldStyle(SampleTextFieldStyle())

                Button("サンプル編集") {
                    viewModel.input.editButtonTapped.send(())
                }
                .buttonStyle(SampleButtonStyle())
            }
            .padding(.init(top: .zero, leading: 32, bottom: .zero, trailing: 32))
            .navigationTitle("サンプル編集")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(isPresented: viewModel.$binding.isCompleted) {
            Alert(
                title: Text("サンプル編集完了"),
                message: Text("タイトル名「\(viewModel.output.modelObject?.title ?? "???")」に編集完了しました"),
                dismissButton: .default(Text("閉じる")) {
                    mode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct SampleEditView_Previews: PreviewProvider {
    static var previews: some View {
        SampleEditView(
            viewModel: ViewModels.Sample.Edit(
                modelObject: SampleModelObjectBuilder().build()
            )
        )
    }
}

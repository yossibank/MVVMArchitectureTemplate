import SwiftUI

struct SampleDetailView: View {
    @StateObject var viewModel: SampleDetailViewModel

    @State private var isShowSheet = false

    init(modelObject: SampleModelObject) {
        _viewModel = .init(wrappedValue: ViewModels.Sample.Detail(modelObject: modelObject))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            Text("ID: \(viewModel.output.modelObject?.userId.description ?? "")")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.secondary)

            Text("UserID: \(viewModel.output.modelObject?.id.description ?? "")")
                .font(.system(size: 14))
                .foregroundColor(.red)

            Text(viewModel.output.modelObject?.title ?? "")
                .font(.system(size: 18, weight: .heavy))

            Text(viewModel.output.modelObject?.body ?? "")
                .font(.system(size: 16))
                .italic()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.top, .leading, .trailing], 32)
        .navigationTitle("サンプル詳細")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                isShowSheet = true
            } label: {
                Image(systemName: "list.clipboard")
                    .tint(.primary)
            }
        }
        .onAppear {
            viewModel.input.onAppear.send(())
        }
        .sheet(isPresented: $isShowSheet) {
            if let modelObject = viewModel.output.modelObject {
                viewModel.router.routeToEdit(modelObject: modelObject)
            }
        }
    }
}

struct SampleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SampleDetailView(modelObject: SampleModelObjectBuilder().build())
        }
    }
}

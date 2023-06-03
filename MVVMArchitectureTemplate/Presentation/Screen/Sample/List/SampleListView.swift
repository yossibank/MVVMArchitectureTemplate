import SwiftUI

struct SampleListView: View {
    @StateObject private var viewModel = ViewModels.Sample.List()

    var body: some View {
        NavigationView {
            List(viewModel.output.modelObjects, id: \.self) {
                SampleRow(modelObject: $0)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
            }
//            .overlay {
//                if viewModel.output.isLoading {
//                    ProgressView("読み込み中。。。")
//                        .progressViewStyle(.circular)
//                        .tint(.primary)
//                        .foregroundColor(.primary)
//                }
//            }
            .navigationTitle("サンプル一覧")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .redacted(reason: viewModel.output.isLoading ? .placeholder : [])
            .onAppear {
                viewModel.input.onAppear.send(())
            }
        }
    }
}

struct SampleListView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListView()
    }
}

import SwiftUI

struct SampleDetailScreenView: View {
    @StateObject var viewModel: SampleDetailViewModel

    init(viewModel: SampleDetailViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            Text("ID: \(viewModel.state.modelObject.id.description)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.secondary)

            Text("UserID: \(viewModel.state.modelObject.userId.description)")
                .font(.system(size: 14))
                .foregroundColor(.red)

            Text(viewModel.state.modelObject.title)
                .font(.system(size: 18, weight: .heavy))

            Text(viewModel.state.modelObject.body)
                .font(.system(size: 16))
                .italic()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.top, .leading, .trailing], 32)
        .toolbar {
            Image(systemName: "list.clipboard")
                .tint(.primary)
                .onTapGesture {
                    viewModel.editButtonTapped()
                }
        }
    }
}

#Preview {
    SampleDetailScreenView(
        viewModel: SampleDetailViewModel(
            state: .init(modelObject: SampleModelObjectBuilder().build()),
            dependency: .init(analytics: FirebaseAnalytics(screenId: .sampleDetail))
        )
    )
}

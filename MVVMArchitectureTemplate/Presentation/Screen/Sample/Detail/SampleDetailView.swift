import SwiftUI

struct SampleDetailView: View {
    @State private var isPresented = false

    var modelObject: SampleModelObject

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Text("ユーザーID: \(modelObject.userId.description)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.red)

                Spacer()

                Text("ID: \(modelObject.id.description)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
            }

            Text(modelObject.title)
                .font(.system(size: 18, weight: .heavy))

            Text(modelObject.body)
                .font(.system(size: 16))
                .italic()
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.init(top: .zero, leading: 32, bottom: .zero, trailing: 32))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "list.clipboard")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            SampleEditView(viewModel: ViewModels.Sample.Edit(modelObject: modelObject))
        }
    }
}

struct SampleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SampleDetailView(modelObject: SampleModelObjectBuilder().build())
    }
}

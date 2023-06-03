import SwiftUI

struct SampleRow: View {
    var modelObject: SampleModelObject

    var body: some View {
        HStack(spacing: 16) {
            Text("ID: \(modelObject.id.description)")
                .font(.system(size: 10))
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text("UserID: \(modelObject.userId.description)")
                    .font(.system(size: 10))
                    .lineLimit(1)

                Text(modelObject.title)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .lineLimit(2)

                Text(modelObject.body)
                    .font(.system(size: 11))
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SampleRow_Previews: PreviewProvider {
    static var previews: some View {
        SampleRow(modelObject: SampleModelObjectBuilder().build())
    }
}

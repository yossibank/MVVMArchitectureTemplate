#if DEBUG
    final class SampleModelObjectBuilder {
        static let placeholder: [SampleModelObject] = (0 ... 19).map {
            SampleModelObjectBuilder()
                .userId($0 + 1)
                .id($0 + 1)
                .title("placeholder placeholder")
                .body("placeholder placeholder")
                .build()
        }

        private var userId = 1
        private var id = 1
        private var title = "sample title"
        private var body = "sample body"

        func build() -> SampleModelObject {
            .init(
                userId: userId,
                id: id,
                title: title,
                body: body
            )
        }

        func userId(_ userId: Int) -> Self {
            self.userId = userId
            return self
        }

        func id(_ id: Int) -> Self {
            self.id = id
            return self
        }

        func title(_ title: String) -> Self {
            self.title = title
            return self
        }

        func body(_ body: String) -> Self {
            self.body = body
            return self
        }
    }
#endif

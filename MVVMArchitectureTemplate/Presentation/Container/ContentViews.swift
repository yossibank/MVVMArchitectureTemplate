enum ContentViews {
    enum Sample {
        static func Add() -> SampleAddContentView {
            .init()
        }

        static func Detail(modelObject: SampleModelObject) -> SampleDetailContentView {
            .init(modelObject: modelObject)
        }

        static func List() -> SampleListContentView {
            .init()
        }
    }
}

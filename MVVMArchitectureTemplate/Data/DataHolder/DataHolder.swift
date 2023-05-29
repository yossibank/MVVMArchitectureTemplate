import Foundation

enum DataHolder {
    @UserDefaultsStorage(
        .sample,
        defaultValue: .sample1
    )
    static var sample: DataHolder.Sample
}

extension DataHolder {
    @FileStorage(fileName: FileName.someFile.rawValue)
    static var someFile: [String]?
}

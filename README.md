# MVVMArchitectureTemplate

![Apple](https://img.shields.io/badge/Apple-%23777777.svg?style=for-the-badge&logo=apple&logoColor=white) ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white) ![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white) ![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white) ![iOS](https://img.shields.io/badge/iOS-008000?style=for-the-badge&logo=ios&logoColor=white) ![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)  ![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)

## App Screen(Snapshot)

* [List Screen](https://github.com/yossibank/MVVMArchitectureTemplate/blob/main/MVVMArchitectureTemplateTests/Reports/Sample%E4%B8%80%E8%A6%A7%E7%94%BB%E9%9D%A2.md)
* [Edit Screen](https://github.com/yossibank/MVVMArchitectureTemplate/blob/main/MVVMArchitectureTemplateTests/Reports/Sample%E7%B7%A8%E9%9B%86%E7%94%BB%E9%9D%A2.md)
* [Detail Screen](https://github.com/yossibank/MVVMArchitectureTemplate/blob/main/MVVMArchitectureTemplateTests/Reports/Sample%E8%A9%B3%E7%B4%B0%E7%94%BB%E9%9D%A2.md)
* [Add Screen](https://github.com/yossibank/MVVMArchitectureTemplate/blob/main/MVVMArchitectureTemplateTests/Reports/Sample%E8%BF%BD%E5%8A%A0%E7%94%BB%E9%9D%A2.md)

※ Example

|タイトル長文ダークモード|タイトル長文ライトモード|
|:---:|:---:|
|16.4|16.4|
|iPhone14|iPhone14|
|<img src='MVVMArchitectureTemplateSnapshotTests/ReferenceImages_64/Sample詳細画面/testSampleDetailView_タイトル_長文_ダークモード_iPhone_17_2_393x852@3x.png' width='250' style='border: 1px solid #999' />|<img src='MVVMArchitectureTemplateSnapshotTests/ReferenceImages_64/Sample詳細画面/testSampleDetailView_タイトル_長文_ライトモード_iPhone_17_2_393x852@3x.png' width='250' style='border: 1px solid #999' />|

## Target OS

* **above iOS15**

## Library

* **Firebase**
* **Mockolo**
* **OHHTTPStubs**
* **iOSSnapshotTestCase**

## Tool

* **SwiftFormat**
* **SwiftLint**
* **SwiftGen**
* **XcodeGen**

## Architecture

**MVVM + Swift Concurrency + SwiftUI**

* **Model**(Target UnitTest)
  - **Converter**

* **ViewModel**(Target UnitTest)
  - **Router**

* **View**(Target SnapshotTest)

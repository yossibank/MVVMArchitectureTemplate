# MVVMArchitectureTemplate

## アプリ画面(Snapshot)

* [一覧画面](https://github.com/yossibank/MVVMArchitectureTemplate/blob/main/MVVMArchitectureTemplateTests/Reports/Sample%E4%B8%80%E8%A6%A7%E7%94%BB%E9%9D%A2.md)
* [編集画面](https://github.com/yossibank/MVVMArchitectureTemplate/blob/main/MVVMArchitectureTemplateTests/Reports/Sample%E7%B7%A8%E9%9B%86%E7%94%BB%E9%9D%A2.md)
* [詳細画面](https://github.com/yossibank/MVVMArchitectureTemplate/blob/main/MVVMArchitectureTemplateTests/Reports/Sample%E8%A9%B3%E7%B4%B0%E7%94%BB%E9%9D%A2.md)
* [追加画面](https://github.com/yossibank/MVVMArchitectureTemplate/blob/main/MVVMArchitectureTemplateTests/Reports/Sample%E8%BF%BD%E5%8A%A0%E7%94%BB%E9%9D%A2.md)

※ 画面例

|タイトル長文ダークモード|タイトル長文ライトモード|
|:---:|:---:|
|16.4|16.4|
|iPhone14|iPhone14|
|<img src='MVVMArchitectureTemplateSnapshotTests/ReferenceImages_64/Sample詳細画面/testSampleDetailView_タイトル_長文_ダークモード_iPhone_16_4_390x844@3x.png' width='390' style='border: 1px solid #999' />|<img src='MVVMArchitectureTemplateSnapshotTests/ReferenceImages_64/Sample詳細画面/testSampleDetailView_タイトル_長文_ライトモード_iPhone_16_4_390x844@3x.png' width='390' style='border: 1px solid #999' />|

## 対象OS

* iOS15以降

## 導入ライブラリ

* **Firebase**
* **OHHTTPStubs**
* **iOSSnapshotTestCase**
* **Mockolo**

## 導入ツール

* **SwiftFormat**
* **SwiftLint**
* **SwiftGen**
* **XcodeGen**

## プロジェクト設定

* `project.yml`内で管理、以下コマンド実行

```
make setup
```

## アーキテクチャ

**MVVM**

* **Model**(単体テスト対象)

* **ViewModel**(単体テスト対象)
  - **Router**(画面遷移管理)保持

* **View**(スナップショットテスト対象)

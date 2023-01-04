### 定数定義 ###
LINES_TO_SPLIT = 1000

### 対象コード以外についてのメッセージは除く ###
github.dismiss_out_of_range_messages

### PR ###
pr_body_lines = github.pr_body.length
modified_lines = git.lines_of_code

if modified_lines > 10 && pr_body_lines < 10
    warn("💣 作業内容について詳細に説明してください(10行以上)")
end

if modified_lines > LINES_TO_SPLIT
    warn("💣 PRの変更量が1000行を超えています")
end

### コード ###
ignored_rule_ids = [
    "todo"
]

swiftlint.config_file = ".swiftlint.yml"
swiftlint.lint_files(inline_mode: true) do |violation|
    !ignored_rule_ids.include?(violation["rule_id"])
end

### Periphery ###
periphery.scan(
    project: "MVVMArchitectureTemplate.xcodeproj",
    schemes: "MVVMArchitectureTemplate",
    targets: "MVVMArchitectureTemplate",
    skip_build: true,
    index_store_path: 'DerivedData/Index.noindex/DataStore'
)

### コードカバレッジ ###
system("mint run xcparse codecov MVVMArchitectureTemplate.xcresult ./")

xcov.report(
    project: "MVVMArchitectureTemplate.xcodeproj",
    scheme: "MVVMArchitectureTemplate",
    xccov_file_direct_path: "action.xccovreport",
    minimum_coverage_percentage: 60.0,
    only_project_targets: true
)
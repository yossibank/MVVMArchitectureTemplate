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

### コードカバレッジ ###
slather.configure("MVVMArchitectureTemplate.xcodeproj", "MVVMArchitectureTemplate")
# slather.notify_if_coverage_is_less_than(minimum_coverage: 80)
# slather.notify_if_modified_file_is_less_than(minimum_coverage: 60)
slather.show_coverage
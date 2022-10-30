### 定数定義 ###
LINES_TO_SPLIT = 1000

### 対象コード以外についてのメッセージは除く ###
github.dismiss_out_of_range_messages

### 差分 ###
modified_lines = git.lines_of_code

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
# CS169 hw-sinatra-saas-wordguesser（SAAS edX hw-sinatra-saas-wordguesser）

## 已通过的公开验证（2026-11-08）

验收分支 `edidada/cs169-hw`，HEAD `9e601cd033f259e545f3b2295719a01ad1def941`，[Actions run 42497255126](https://github.com/edidada/cs169-hw-sinatra-saas-wordguesser/actions/runs/42497255126) 成功：

- 官方原版 spec_run（pending 示例保留原状，被 spec_helper 过滤）：0 examples, 0 failures——与官方基线一致，原 spec 文件未改动；
- 移除 pending 状态后的完整断言集：**18/18 通过**——guessing（重复/case-insensitive/nil-空-非字母 ArgumentError）、displayed word with guesses（b-n-n- / ------ / banana）、game status（win/lose/play）与 controller 层（routes / new / keep guesses etc.，官方 app.rb 未改动）。

## 实现

`lib/wordguesser_game.rb`：`guesses`/`wrong_guesses` 为字符串衍生列表；`guess(letter)` 统一大小写、去重（返回 false）、记录、正确/错误分流；`word_with_guesses` 输出 '-' 填充的披露字符串；`check_win_or_lose` 依 MAX_WRONG=7 的 lose 边界和 word 全揭露 win 门槛；引入字符串 O(1) 判断等。spec_helper 使 Sintra/WebMock 依赖随官方配置工作（webmock 拦截外部 random-word 请求）。

## 边界与局限

- 本仓库 spec 仅 18 it 断言全部运行（规格与 `spec/wordguesser_game_spec.rb` 完全对应），没有超过官方断言覆盖面的自我扩展。
- 不覆盖 Gradescore 私有自动评分、无 sinatra-host 页面手动浏览验收，21 点状态机只按 spec 断言。

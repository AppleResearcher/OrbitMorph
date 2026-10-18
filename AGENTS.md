# OrbitMorph AI 协作与版本管理规范

本仓库是 AppleResearcher/OrbitMorph Fork 的本地开发工作区；原作者仓库为 samni728/OrbitMorph。默认使用简体中文交流、记录与提交。

## Git 与发布
- origin 为 AppleResearcher 的个人 Fork；upstream 仅用于读取和合并原作者更新，不允许推送。
- main 仅保留已验证的稳定版本；日常工作在 dev。独立功能使用 feature/<short-name>，修复使用 fix/<short-name>；小修复不必机械新建分支。
- 功能分支完成后合并到 dev，综合验收后再经 PR 合并到 main。不强推、不重写共享分支历史、不覆盖别人工作。
- Git 作者采用本仓库局部的 AppleResearcher 身份，不覆盖其他仓库。Commit、Issue、PR 使用中文描述；分支名与代码标识使用英文。
- 提交前检查 git status、git diff --check，只提交本次任务文件。敏感信息、个人样本、访问令牌和构建产物不得进入 Git。

## 产品与架构
- 首先保持原版能够构建、运行和测试，改动前记录可复现的原版基线。
- 保留 OrbitMorphApp（界面/拖拽）和 OrbitMorphCore（格式/转换事务）的边界。扩展格式要验证真实内容，不以扩展名冒充能力。
- 保护用户原始文件及临时写入、验证、排他提交、失败回滚机制。文件转换默认在本机完成，不增加隐式上传或遥测。
- 原生 macOS 体验遵循 Apple HIG；真实 Finder 拖拽、多屏、暗色模式、辅助功能场景需实际验收，Swift 测试不能替代人工体验。
- 原仓库未指定统一源码许可证；不要自行增加授权声明或假定允许任意再分发。

## 构建与记录
- 常规：swift build、swift test、git diff --check。
- 应用：scripts/build-app.sh 输出 dist/OrbitMorph.app；scripts/package-dmg.sh 可生成 DMG。编译产物不入 Git。
- 完整转换矩阵：ORBITMORPH_FULL_MATRIX=1 swift test，仅在本机依赖齐全时运行；不可引用原作者历史数字代替实测。
- 规划、环境说明、开发日志和验收结果统一放在 docs/gt-development/。

## 本地目录及安全边界
- 本机源码位置：~/AgentLibrary/projects/OrbitMorph；不移入 ~/Docker。
- ~/Docker 是现有服务和数据运行区；未验证路径、bind mount 和回滚方案，不得移动目录或改动服务。
- 不擅自删除、停用其他服务，不复制凭据到聊天、其他 AgentDock 节点或仓库。跨设备开发使用 GitHub 独立克隆。
- 修改原作者仓库、正式发布、设置系统登录项、全局环境调整、正式签名或公证等外部动作必须另行评估和授权。

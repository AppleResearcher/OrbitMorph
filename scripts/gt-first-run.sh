#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
export DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode.app/Contents/Developer}"
cd "$ROOT"

if [[ ! -d "$DEVELOPER_DIR" ]]; then
  echo "错误：未找到完整 Xcode 开发目录：$DEVELOPER_DIR" >&2
  exit 1
fi

if ! xcrun --find swift >/dev/null 2>&1; then
  echo "Xcode 尚未完成首次初始化或许可证确认。" >&2
  echo "请在 Mac mini 上打开 Xcode 并完成首次启动，或在终端运行 sudo xcodebuild -license 阅读和接受条款。" >&2
  echo "确认后重新运行本脚本；无需更改系统全局 xcode-select。" >&2
  exit 69
fi

echo "==> Swift 构建与测试（Xcode-scoped）"
swift build --jobs 4 --scratch-path /tmp/orbitmorph-gt-xcode-build
swift test --jobs 4 --scratch-path /tmp/orbitmorph-gt-xcode-build

echo "==> 构建原生 App"
SCRATCH_PATH=/tmp/orbitmorph-gt-xcode-release "$ROOT/scripts/build-app.sh"

echo "==> 打开 Mac mini 本地 App"
open "$ROOT/dist/OrbitMorph.app"
echo "完成。位置：$ROOT/dist/OrbitMorph.app"

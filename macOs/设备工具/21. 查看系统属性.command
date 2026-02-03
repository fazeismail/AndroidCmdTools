#!/bin/bash
shellDirPath="$(cd "$(dirname "$0")/../.." || exit 1; pwd)/shell"

if [[ ! -d "${shellDirPath}" ]]; then
    echo "❌ 错误：${shellDirPath} 目录不存在"
    exit 1
fi

shellFilePath="${shellDirPath}/device-tools/GetSystemProperties.sh"

if [[ ! -f "${shellFilePath}" ]]; then
    echo "❌ 没找到 shell 文件，请检查 ${shellFilePath} 路径是否正确"
    exit 1
fi

if [[ ! -x "${shellFilePath}" ]]; then
    echo "💡 脚本无执行权限，尝试添加..."
    echo "⏳ 正在尝试为脚本添加执行权限..."
    if ! find "${shellDirPath}" -type f -exec chmod +x {} \;; then
        echo "❌ 为脚本添加权限失败，请手动执行命令：find ${shellDirPath} -type f -exec chmod +x {} \;"
        exit 1
    fi
    echo "✅ 为脚本添加执行权限成功"
fi

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" || exit 1

"${shellFilePath}"
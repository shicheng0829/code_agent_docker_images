#!/usr/bin/env bash

# 脚本将在任何命令失败时立即退出
set -e
# 管道中的任何命令失败都会导致整个管道失败
set -o pipefail

# --- 配置 ---
# 包含仓库列表的文件
REPO_LIST_FILE="cpp_repos"
# Dockerfile生成的根目录
BASE_OUTPUT_DIR="/Users/shicheng/Tencent/code_agent_docker_images"
# 克隆代码的根目录 ('.' 表示当前目录)
CLONE_BASE_DIR="."

# --- 脚本开始 ---

# 1. 检查输入文件是否存在
if [ ! -f "$REPO_LIST_FILE" ]; then
    echo "错误: 仓库列表文件 '$REPO_LIST_FILE' 不存在。"
    exit 1
fi

echo "脚本开始，将从 '$REPO_LIST_FILE' 读取仓库列表。"
echo "生成的 Dockerfile 将被放置在 '$BASE_OUTPUT_DIR' 下。"
echo "----------------------------------------------------"

# 2. 逐行读取仓库列表文件
# 使用 `|| [[ -n "$REPO_FULL_NAME" ]]` 来确保处理文件的最后一行（如果它没有换行符）
while IFS= read -r REPO_FULL_NAME || [[ -n "$REPO_FULL_NAME" ]]; do
    # 跳过空行或以'#'开头的注释行
    if [[ -z "$REPO_FULL_NAME" || "$REPO_FULL_NAME" == \#* ]]; then
        continue
    fi

    # 3. 解析 OrgName 和 RepoName
    # 使用Bash参数扩展，比`cut`命令更高效
    ORG_NAME="${REPO_FULL_NAME%/*}"
    REPO_NAME="${REPO_FULL_NAME#*/}"

    # 检查解析是否成功 (如果'/'不存在, ORG_NAME和REPO_NAME会相同)
    if [ "$ORG_NAME" == "$REPO_NAME" ]; then
        echo "警告: 无效的仓库格式 '$REPO_FULL_NAME'，跳过。"
        continue
    fi

    echo "=> 正在处理仓库: ${REPO_FULL_NAME}"

    # 定义相关路径和URL
    GIT_URL="git@github.com:${REPO_FULL_NAME}.git"
    REPO_CLONE_PATH="${CLONE_BASE_DIR}/${REPO_NAME}"
    DOCKERFILE_OUTPUT_DIR="${BASE_OUTPUT_DIR}/${ORG_NAME}/${REPO_NAME}"
    DOCKERFILE_OUTPUT_PATH="${DOCKERFILE_OUTPUT_DIR}/Dockerfile"

    # 4. 克隆或跳过仓库
    if [ -d "$REPO_CLONE_PATH" ]; then
        echo "  -> 目录 '${REPO_CLONE_PATH}' 已存在，跳过 git clone。"
        # 如果需要，你可以在这里取消注释来更新现有仓库
        # echo "  -> 更新仓库..."
        # (cd "$REPO_CLONE_PATH" && git pull)
    else
        echo "  -> 正在克隆 ${GIT_URL} 到 '${REPO_CLONE_PATH}'..."
        # --depth 1 只克隆最新版本，加快速度
        git clone --depth 1 "$GIT_URL" "$REPO_CLONE_PATH"
    fi

    # 5. 创建最终生成Dockerfile的输出目录
    echo "  -> 确保输出目录存在: ${DOCKERFILE_OUTPUT_DIR}"
    mkdir -p "$DOCKERFILE_OUTPUT_DIR"

    # 6. 构建 qwen 命令的 prompt
    QWEN_PROMPT="生成一个开发用的dockerfile，运行单元测试。开发的dockerfile参考这个repo里的ci配置。可以搜一搜yaml/yml/toml文件，最终生成的dockerfile文件帮我生成到${DOCKERFILE_OUTPUT_PATH}的位置"

    # 7. 进入仓库目录并执行命令
    # 使用子shell (...) 来执行，这样cd命令不会影响脚本的主工作目录，非常安全
    (
        echo "  -> 进入目录: ${REPO_CLONE_PATH}"
        cd "$REPO_CLONE_PATH"

        echo "  -> 正在执行 qwen 命令..."
        # 为了调试，可以先打印命令而不是执行它
        # echo "qwen -p \"$QWEN_PROMPT\" -y"

        # 执行实际命令
        qwen -p "$QWEN_PROMPT" -y

        echo "  -> qwen 命令执行完毕。"
    )

    echo "=> 完成处理: ${REPO_FULL_NAME}"
    echo "----------------------------------------------------"

done < "$REPO_LIST_FILE"

echo "所有仓库处理完毕！"
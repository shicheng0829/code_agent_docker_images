#!/usr/bin/env bash

# --- 已移除的设置 ---
# 下面这两行被注释掉了，以确保脚本在命令失败时不会退出。
# set -e
# set -o pipefail


# --- 配置 ---
# 包含仓库列表的文件
REPO_LIST_FILE="cpp_repos"
# 文件生成的根目录
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
echo "生成的文件将被放置在 '$BASE_OUTPUT_DIR' 下。"
echo "----------------------------------------------------"

# 2. 逐行读取仓库列表文件
while IFS= read -r REPO_FULL_NAME || [[ -n "$REPO_FULL_NAME" ]]; do
    # 跳过空行或以'#'开头的注释行
    if [[ -z "$REPO_FULL_NAME" || "$REPO_FULL_NAME" == \#* ]]; then
        continue
    fi

    # 3. 解析 OrgName 和 RepoName
    ORG_NAME="${REPO_FULL_NAME%/*}"
    REPO_NAME="${REPO_FULL_NAME#*/}"

    if [ "$ORG_NAME" == "$REPO_NAME" ]; then
        echo "警告: 无效的仓库格式 '$REPO_FULL_NAME'，跳过。"
        continue
    fi

    echo "=> 正在处理仓库: ${REPO_FULL_NAME}"

    # 定义相关路径和URL
    GIT_URL="git@github.com:${REPO_FULL_NAME}.git"
    REPO_CLONE_PATH="${CLONE_BASE_DIR}/${REPO_NAME}"
    FINAL_OUTPUT_DIR="${BASE_OUTPUT_DIR}/${ORG_NAME}/${REPO_NAME}"

    # 4. 清理并克隆仓库
    echo "  -> 清理可能存在的旧目录: ${REPO_CLONE_PATH}"
    rm -rf "$REPO_CLONE_PATH"

    echo "  -> 正在克隆 ${GIT_URL} 到 '${REPO_CLONE_PATH}'..."
    if ! git clone --depth 1 "$GIT_URL" "$REPO_CLONE_PATH"; then
        echo "  -> 错误: 克隆仓库 ${REPO_FULL_NAME} 失败。跳过此仓库。"
        echo "----------------------------------------------------"
        continue
    fi

    # 5. 创建最终的输出目录
    echo "  -> 确保输出目录存在: ${FINAL_OUTPUT_DIR}"
    mkdir -p "$FINAL_OUTPUT_DIR"

    # 6. 构建 qwen 命令的 prompt
    QWEN_PROMPT="生成一个开发用的Dockerfile，运行单元测试。开发的Dockerfile参考这个repo里的ci配置。可以搜一搜yaml/yml/toml文件。生成的文件名使用Dockerfile，需要实际测试这个Dockerfile是否能运行，请确保生成的Dockerfile能在本地运行。"

    # 7. 进入仓库目录，执行命令，并移动生成的文件
    (
        if [ ! -d "$REPO_CLONE_PATH" ]; then
            echo "  -> 错误: 克隆目录 '${REPO_CLONE_PATH}' 不存在，无法继续。"
            exit 1
        fi

        echo "  -> 进入目录: ${REPO_CLONE_PATH}"
        cd "$REPO_CLONE_PATH"

        echo "  -> 正在执行 qwen 命令以生成文件..."
        qwen -p "$QWEN_PROMPT" -y
        # 捕获 qwen 命令的退出码
        QWEN_EXIT_CODE=$?

        # 根据退出码打印信息，但这不再影响后续操作
        if [ $QWEN_EXIT_CODE -eq 0 ]; then
            echo "  -> qwen 命令执行成功。"
        else
            echo "  -> 警告: qwen 命令执行失败 (退出码: $QWEN_EXIT_CODE)，但仍将继续尝试移动文件。"
        fi

        # 8. 查找所有新生成或被修改的文件并移动它们 (此部分现在无条件执行)
        echo "  -> 正在查找并移动新生成或修改的文件..."

        files_found=0
        git status --porcelain | grep -v '^ D' | cut -c 4- | while IFS= read -r file_path; do
            if [ -f "$file_path" ]; then
                files_found=1
                target_file_path="${FINAL_OUTPUT_DIR}/${file_path}"
                target_file_dir=$(dirname "${target_file_path}")

                echo "    -> 发现文件: ${file_path}"
                mkdir -p "${target_file_dir}"
                mv "$file_path" "$target_file_path"
                echo "    -> 已移动到: ${target_file_path}"
            fi
        done

        if [ "$files_found" -eq 0 ]; then
            echo "  -> 未检测到任何新生成或修改的文件。"
        fi
    )

    # 9. 清理克隆的仓库
    echo "  -> 处理完毕，删除仓库目录: ${REPO_CLONE_PATH}"
    rm -rf "$REPO_CLONE_PATH"

    echo "=> 完成处理: ${REPO_FULL_NAME}"
    echo "----------------------------------------------------"

done < "$REPO_LIST_FILE"

echo "所有仓库处理完毕！"
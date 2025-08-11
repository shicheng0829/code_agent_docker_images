#!/bin/bash

# mxml-dev.sh - Mini-XML 开发环境脚本

# 检查是否提供了参数
if [ $# -eq 0 ]; then
    echo "用法: $0 [build|test|shell|run|clean]"
    echo "  build - 构建项目"
    echo "  test  - 运行测试"
    echo "  shell - 启动交互式shell"
    echo "  run   - 编译并运行指定的C文件"
    echo "  clean - 清理构建产物"
    exit 1
fi

COMMAND=$1
shift

case $COMMAND in
    build)
        docker run --rm -v /data2/code_agent_docker_images/mxml:/app mxml-dev bash -c "cd /app && ./configure --enable-debug --enable-maintainer --with-sanitizer && make"
        ;;
    test)
        docker run --rm -v /data2/code_agent_docker_images/mxml:/app mxml-dev bash -c "cd /app && ./configure --enable-debug --enable-maintainer --with-sanitizer && make && make test"
        ;;
    shell)
        docker run -it --rm -v /data2/code_agent_docker_images/mxml:/app mxml-dev
        ;;
    clean)
        docker run --rm -v /data2/code_agent_docker_images/mxml:/app mxml-dev bash -c "cd /app && rm -f *.o testmxml libmxml* config.h Makefile mxml4.pc"
        ;;
    run)
        if [ $# -eq 0 ]; then
            echo "错误: run 命令需要指定可执行文件"
            exit 1
        fi
        FILE=$1
        shift
        docker run --rm -v /data2/code_agent_docker_images/mxml:/app mxml-dev bash -c "cd /app && ./configure --enable-debug --enable-maintainer --with-sanitizer && make && ./$FILE $*"
        ;;
    *)
        echo "未知命令: $COMMAND"
        echo "用法: $0 [build|test|shell|run|clean]"
        exit 1
        ;;
esac
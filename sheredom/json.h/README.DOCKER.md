# json.h Docker 开发环境

这个项目提供了一个Docker开发环境，用于构建和测试json.h库。

## 使用方法

### 构建Docker镜像

```bash
docker build -t json-h-dev .
```

### 运行测试

```bash
# 构建并运行所有测试
docker run --rm json-h-dev ./dev.sh

# 只构建项目
docker run --rm json-h-dev ./dev.sh build

# 构建并运行测试
docker run --rm json-h-dev ./dev.sh test

# 清理构建文件
docker run --rm json-h-dev ./dev.sh clean

# 启动交互式开发环境
docker run -it json-h-dev ./dev.sh dev
```

### 挂载本地代码进行开发

```bash
# 挂载当前目录到容器中进行开发
docker run -it -v $(pwd):/app json-h-dev ./dev.sh dev

# 在交互式环境中构建和测试
docker run -it -v $(pwd):/app json-h-dev ./dev.sh dev
# 然后在容器内运行:
# ./dev.sh build
# ./dev.sh test
```

## 开发脚本命令

- `build` - 构建项目
- `test` - 运行测试
- `clean` - 清理构建文件
- `dev` - 启动交互式开发环境
- 不带参数 - 构建并运行测试（默认行为）

## 要求

- Docker

## 镜像包含的工具

- Ubuntu 20.04
- build-essential
- cmake
- gcc/g++
- clang
- git
- vim
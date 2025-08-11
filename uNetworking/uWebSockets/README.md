# uWebSockets 开发环境

这个目录包含了用于uWebSockets项目开发和测试的Docker环境。

## 文件说明

- `Dockerfile.dev` - 用于构建开发环境的Dockerfile
- `run-tests.sh` - 自动构建镜像并运行测试的脚本

## 使用方法

### 1. 运行测试

```bash
./run-tests.sh
```

这个脚本会：
1. 构建Docker镜像
2. 在容器中运行所有单元测试

### 2. 手动构建和运行

```bash
# 构建开发环境镜像
docker build -t uwebsocket-dev -f Dockerfile.dev .

# 运行测试
docker run --rm uwebsocket-dev

# 或者进入交互式shell进行开发
docker run -it --rm uwebsocket-dev bash
```

## 环境说明

开发环境基于Ubuntu 20.04，包含了以下组件：
- 构建工具（build-essential, cmake等）
- Git
- SSL开发库
- Deno（用于某些测试）

构建过程会自动初始化所有子模块并构建项目依赖。
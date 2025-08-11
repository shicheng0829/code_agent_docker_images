# 开发环境 Docker 配置

本项目包含两个Dockerfile，用于构建和测试daw_json_link库：

## 文件说明

1. `Dockerfile` - 完整的构建环境，包含升级的CMake和其他依赖项
2. `Dockerfile.dev` - 简化版的开发环境，适用于日常开发和测试

## 使用方法

### 构建完整镜像

```bash
docker build -t daw-json-link-test .
```

### 构建开发镜像

```bash
docker build -f Dockerfile.dev -t daw-json-link-dev .
```

### 运行测试

```bash
# 运行完整镜像的测试
docker run --rm daw-json-link-test

# 运行开发镜像的测试
docker run --rm daw-json-link-dev
```

### 进入开发容器进行调试

```bash
docker run -it --rm daw-json-link-dev bash
```

这将启动一个交互式的bash会话，您可以在其中运行ctest命令或进行其他开发工作。

## 镜像特点

- 基于Ubuntu 22.04
- 包含所有必要的构建工具和依赖项
- 升级了CMake以支持项目所需的策略
- 构建了所有CI测试
- 可直接运行测试套件验证构建正确性
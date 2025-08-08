# Docker 开发环境

这个项目包含一个用于开发和测试的Docker环境。

## 构建Docker镜像

```bash
docker build -t cppbenchmark-dev .
```

## 运行单元测试

```bash
docker run --rm cppbenchmark-dev /app/temp/cppbenchmark-tests --success
```

## 环境说明

- 基于 Ubuntu 22.04
- 包含所有必要的构建依赖项
- 使用CMake 3.22进行构建
- 自动下载和设置项目依赖项
- 构建项目并运行单元测试

注意：有一个关于CPU时钟速度的测试可能会在容器环境中失败，这是正常的，因为它依赖于特定的硬件信息，在容器中可能无法正确获取。
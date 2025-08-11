# Sonic-Cpp 开发环境 Docker 镜像

这个 Docker 镜像为 Sonic-Cpp 提供了一个完整的开发和测试环境。

## 构建镜像

```bash
docker build -t sonic-cpp-dev .
```

## 运行测试

```bash
docker run --rm sonic-cpp-dev
```

## 进入开发环境

```bash
docker run -it --rm -v $(pwd):/sonic-cpp sonic-cpp-dev bash
```

## 特性

- 基于 Ubuntu 20.04
- 包含所有必要的构建工具（GCC, CMake等）
- 自动检测架构（x86_64 或 aarch64）并相应调整构建配置
- 在 ARM64 上运行时会自动排除 x86 特定的测试
- 包含 Bazel 构建工具

## 支持的平台

- x86_64 (Intel/AMD)
- aarch64 (ARM64)

在 ARM64 平台上，镜像会自动调整构建配置以避免使用 x86 特定的指令集（如 AVX2）。
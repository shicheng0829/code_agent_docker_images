# replxx 开发环境 Docker 镜像

这个 Docker 镜像为 replxx 库提供了一个完整的开发环境。

## 特性

- 基于 Ubuntu 18.04 (bionic)
- 包含所有必要的构建工具和依赖项
- 安装了新版本的 CMake (3.25.2)
- 构建了 replxx 库和示例程序（调试和发布模式）

## 使用方法

### 构建镜像

```bash
docker build -t replxx-dev .
```

### 运行测试

```bash
# 运行所有测试（跳过8位编码测试）
docker run --rm replxx-dev

# 或者明确指定跳过8位编码测试
docker run --rm replxx-dev env SKIP=8bit_encoding ./tests.py
```

### 运行特定测试

```bash
# 运行特定的测试用例
docker run --rm replxx-dev ./tests.py ReplxxTests.test_unicode
```

### 交互式使用

```bash
# 启动交互式 shell
docker run -it --rm replxx-dev bash
```

## 构建产物

镜像中包含以下构建产物：

- 调试版本：
  - `/app/build/debug/libreplxx-d.so` - 共享库
  - `/app/build/debug/libreplxx-d.a` - 静态库
  - `/app/build/debug/replxx-example-cxx-api` - C++ API 示例
  - `/app/build/debug/replxx-example-c-api` - C API 示例

- 发布版本：
  - `/app/build/release/libreplxx.so` - 共享库
  - `/app/build/release/libreplxx.a` - 静态库
  - `/app/build/release/replxx-example-cxx-api` - C++ API 示例
  - `/app/build/release/replxx-example-c-api` - C API 示例

## 故障排除

如果测试失败，这可能是由于异步操作的时间敏感性导致的。在容器化环境中，这种问题很常见。
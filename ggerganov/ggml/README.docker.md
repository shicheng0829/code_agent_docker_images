# GGML 开发 Docker 环境

这个Docker环境为GGML库的开发和测试提供了一个完整的、隔离的环境。

## 使用方法

### 构建Docker镜像

```bash
docker build -t ggml-dev .
```

### 运行测试

```bash
docker run --rm ggml-dev
```

### 交互式开发

```bash
docker run -it --rm ggml-dev /bin/bash
```

在交互式shell中，您可以：

1. 修改源代码
2. 重新构建项目：
   ```bash
   cd build && cmake .. -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DGGML_METAL=OFF && cmake --build . --config Release -j $(nproc)
   ```
3. 运行特定的测试：
   ```bash
   cd build && ./bin/test-arange
   ```

### 挂载本地目录进行开发

如果您想在本地编辑代码并在容器中测试：

```bash
docker run -it --rm -v $(pwd):/app ggml-dev /bin/bash
```

这将把当前目录挂载到容器的/app目录中，使您能够在本地编辑代码并在容器中构建和测试。

## 环境详情

- 基于Ubuntu 22.04
- 包含所有必要的构建工具（clang, cmake, ninja等）
- 安装了Python依赖
- 预构建了GGML库和示例程序
- 可直接运行所有单元测试

## 故障排除

如果遇到任何问题，请确保：

1. Docker已正确安装并运行
2. 您有足够的磁盘空间（构建过程需要约2GB空间）
3. 您的系统支持ARM64架构（如果是Apple Silicon Mac）或AMD64

如有其他问题，请查看Dockerfile中的注释或提交issue。
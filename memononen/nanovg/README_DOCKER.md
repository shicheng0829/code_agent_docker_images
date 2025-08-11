# NanoVG 开发环境 Docker 镜像

这个 Docker 镜像提供了 NanoVG 库的完整开发环境，包括所有必要的依赖项和构建工具。

## 构建 Docker 镜像

```bash
docker build -t nanovg-dev .
```

## 使用 Docker 镜像

### 进入开发环境

```bash
docker run -it --rm nanovg-dev
```

### 构建 NanoVG 库

在容器内执行以下命令：

```bash
cd /app/build && make nanovg
```

### 构建示例程序

在容器内执行以下命令来构建特定的示例程序：

```bash
cd /app/build && make example_gl2
```

或者构建所有示例程序：

```bash
cd /app/build && make example_gl2 && make example_gl3 && make example_gl2_msaa && make example_gl3_msaa && make example_fbo && make example_gles2 && make example_gles3
```

### 运行测试脚本

我们提供了两个测试脚本来验证构建：

1. 简单测试（只构建基本示例）：
   ```bash
   ./test_build.sh
   ```

2. 完整测试（构建所有示例）：
   ```bash
   ./run_tests.sh
   ```

## 开发工作流

1. 修改源代码后，重新构建库和相关示例：
   ```bash
   cd /app/build && make clean && make nanovg && make example_gl2
   ```

2. 在主机上编辑代码，在容器中构建和测试：
   ```bash
   docker run -it --rm -v $(pwd):/app nanovg-dev bash
   ```

## 注意事项

- 编译警告是正常的，不会影响功能
- 示例程序需要 OpenGL 环境才能运行，直接在容器中运行可能无法显示图形界面
- 要在本地运行示例程序，需要在支持 OpenGL 的环境中运行
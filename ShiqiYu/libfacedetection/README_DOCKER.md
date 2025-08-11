# libfacedetection 开发环境 Docker 镜像

这个 Docker 镜像提供了 libfacedetection 库的完整开发环境，特别针对 ARM64 架构进行了优化。

## 特性

- 基于 Ubuntu 20.04
- 包含所有必要的依赖项（OpenCV、CMake等）
- 针对 ARM64 架构优化（启用 NEON，禁用 AVX2/AVX512）
- 预编译的示例程序和库文件
- 支持多种使用方式

## 使用方法

### 1. 运行默认基准测试

```bash
docker run --rm libfacedetection-dev
```

这将运行预编译的基准测试程序，测试图像处理性能。

### 2. 列出构建文件

```bash
docker run --rm libfacedetection-dev "ls -la build"
```

### 3. 运行其他命令

你可以通过传递命令作为参数来运行其他操作：

```bash
# 进入交互式shell
docker run -it --rm libfacedetection-dev bash

# 运行特定程序
docker run --rm libfacedetection-dev "cd build && ./detect-image-demo ../images/cnnresult.png"
```

## 构建镜像

如果你修改了源代码并想重新构建镜像：

```bash
docker build -t libfacedetection-dev .
```

## 针对不同架构的优化

该镜像已经针对 ARM64 架构进行了优化：

- 启用了 NEON SIMD 指令集支持
- 禁用了仅适用于 x86-64 的 AVX2 和 AVX512 指令集

## 包含的组件

构建完成后，镜像中包含以下组件：

- `libfacedetection.a` - 静态库文件
- `benchmark` - 性能基准测试程序
- `detect-image-demo` - 图像人脸检测示例
- `detect-camera-demo` - 摄像头人脸检测示例

## 许可证

请参阅原始项目的 LICENSE 文件。
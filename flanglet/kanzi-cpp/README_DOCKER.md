# Kanzi C++ 开发环境 Docker 镜像

这个 Docker 镜像提供了一个完整的开发环境，用于构建和测试 Kanzi C++ 压缩库。

## 构建 Docker 镜像

```bash
docker build -t kanzi-dev .
```

## 使用方法

### 查看可用的测试命令

```bash
docker run --rm kanzi-dev
```

### 运行特定测试

```bash
# 运行 BWT 测试
docker run --rm kanzi-dev "../bin/testBWT"

# 运行变换测试
docker run --rm kanzi-dev "../bin/testTransforms"

# 运行熵编码测试
docker run --rm kanzi-dev "../bin/testEntropyCodec"

# 运行位流测试
docker run --rm kanzi-dev "../bin/testDefaultBitStream"

# 运行压缩流测试
docker run --rm kanzi-dev "../bin/testCompressedStream"
```

### 交互式使用

```bash
docker run --rm -it kanzi-dev bash
```

在交互式 shell 中，您可以访问以下内容：
- 源代码位于 `/app` 目录
- 编译好的测试二进制文件位于 `/app/bin/` 目录
- 可以使用 `make` 命令重新构建项目

### 在宿主机上开发，Docker 内测试

您可以将此 Docker 镜像与宿主机上的源代码挂载一起使用，以便在宿主机上编辑代码，在容器内运行测试：

```bash
docker run --rm -v $(pwd):/app kanzi-dev "../bin/testBWT"
```

## 项目结构

- 源代码：`/app/src/`
- 编译输出：`/app/bin/` 和 `/app/lib/`
- 测试二进制文件：`/app/bin/test*`
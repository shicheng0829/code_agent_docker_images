# 开发指南

## 使用Docker进行开发

本项目包含一个Dockerfile，可用于创建一致的开发环境。

### 构建开发镜像

```bash
docker build -t plutofilter-dev .
```

### 进入开发环境

```bash
docker run --rm -it -v $(pwd):/app plutofilter-dev
```

这将启动一个交互式的容器，将当前目录挂载到容器的`/app`目录中。

### 在容器内构建和测试

一旦进入容器，您可以使用以下命令构建和测试项目：

```bash
# 设置构建目录
meson setup build

# 编译项目
meson compile -C build

# 运行测试
meson test -C build
```

### 直接运行测试

您也可以直接在容器中运行测试，而无需交互式进入：

```bash
docker run --rm plutofilter-dev /bin/bash -c "meson setup build && meson compile -C build && meson test -C build"
```
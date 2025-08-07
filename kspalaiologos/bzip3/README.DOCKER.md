# bzip3 Docker 开发环境

这个目录包含了用于bzip3项目开发的Docker配置文件。

## 文件说明

1. `Dockerfile` - 基础开发环境，用于构建和运行单元测试
2. `Dockerfile.dev` - 扩展开发环境，包含额外的开发工具如vim、gdb和valgrind

## 使用方法

### 构建基础开发环境镜像

```bash
docker build -t bzip3-dev .
```

### 运行单元测试

```bash
docker run --rm bzip3-dev
```

或者手动指定测试命令：

```bash
docker run --rm bzip3-dev make roundtrip test
```

### 构建扩展开发环境镜像

```bash
docker build -t bzip3-dev-env -f Dockerfile.dev .
```

### 进入开发环境进行交互式开发

```bash
docker run -it --rm bzip3-dev-env /bin/bash
```

在容器内，您可以：
- 编辑代码 (vim)
- 调试程序 (gdb)
- 检查内存问题 (valgrind)
- 重新构建项目 (make)

### 重新构建项目

在容器内执行：

```bash
make clean
./configure --disable-arch-native
make
```
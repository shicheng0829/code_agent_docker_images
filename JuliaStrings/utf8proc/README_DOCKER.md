# utf8proc 开发环境 Docker 镜像

这个 Docker 镜像为 utf8proc 库提供了完整的开发和测试环境。

## 构建镜像

```bash
docker build -t utf8proc-dev .
```

## 运行测试

默认情况下，运行容器会自动执行所有测试：

```bash
docker run --rm utf8proc-dev
```

## 交互式开发

如果你想进入容器进行交互式开发，可以使用以下命令：

```bash
docker run -it --rm utf8proc-dev /bin/bash
```

在容器内，你可以：

1. 修改源代码
2. 重新构建项目：
   ```bash
   cd build && cmake .. && make
   ```
3. 单独运行某个测试：
   ```bash
   cd build && ./normtest data/NormalizationTest.txt
   ```

## 镜像包含的工具

- Ubuntu 20.04 基础系统
- GCC 编译器工具链
- CMake 构建系统
- Git 版本控制
- Vim 文本编辑器
- 所有构建和测试 utf8proc 所需的依赖

## 项目结构

在容器中：

- 源代码位于 `/app` 目录
- 构建输出位于 `/app/build` 目录
- 测试数据文件位于 `/app/data` 目录

## 运行特定测试

如果只想运行特定的测试，可以在容器中执行：

```bash
# 运行规范化测试
docker run --rm utf8proc-dev sh -c "cd build && ./normtest data/NormalizationTest.txt"

# 运行字符宽度测试
docker run --rm utf8proc-dev sh -c "cd build && ./charwidth"

# 运行所有测试（默认行为）
docker run --rm utf8proc-dev
```
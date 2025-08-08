# SLJIT 开发环境 Docker 镜像

这个 Docker 镜像为 SLJIT 项目提供了一个完整的开发环境，包括所有必要的构建工具和依赖项。

## 构建 Docker 镜像

```bash
docker build -t sljit-dev .
```

## 运行测试

默认情况下，容器会运行 SLJIT 测试套件：

```bash
docker run --rm sljit-dev
```

## 交互式开发

要以交互模式启动容器进行开发：

```bash
docker run -it --rm -v $(pwd):/app sljit-dev bash
```

这将挂载当前目录到容器中的 `/app` 目录，允许您直接修改主机上的文件并在容器内构建和测试。

## 在容器内执行特定命令

要在容器内执行特定命令（例如运行正则表达式测试）：

```bash
docker run --rm sljit-dev ./bin/regex_test
```

## 可用工具

该开发环境包含以下工具：
- GCC 和 G++ 编译器
- Make 构建工具
- CMake 构建系统
- Git 版本控制
- Vim 文本编辑器
- GDB 调试器
- Valgrind 内存调试工具

## 架构支持

此 Docker 镜像构建的是 x86_64 架构的 SLJIT 库。如需测试其他架构，请参考 `.github/workflows/actions.yml` 中的 CI 配置。
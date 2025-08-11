# Docker 开发环境使用指南

本文档介绍了如何使用为TSMP项目提供的Docker开发环境。

## 先决条件

确保您的系统上已安装Docker。

## 构建开发镜像

要构建开发环境的Docker镜像，请运行以下命令：

```bash
docker build -t tsmp-dev .
```

这将创建一个名为`tsmp-dev`的Docker镜像，其中包含构建和测试TSMP项目所需的所有依赖项和工具。

## 使用开发环境

### 选项1：运行预设的开发脚本

您可以直接运行预设的开发脚本来构建项目并运行测试：

```bash
docker run --rm tsmp-dev /usr/local/bin/dev-setup.sh
```

此命令将：
1. 配置项目（使用CMake）
2. 构建项目
3. 运行所有测试

### 选项2：交互式开发

您也可以启动一个交互式的bash会话，以便手动执行命令：

```bash
docker run -it tsmp-dev
```

在容器内部，您可以：
- 修改源代码
- 手动运行构建命令
- 使用GDB调试程序
- 使用Valgrind进行内存分析

### 选项3：挂载本地源代码

如果您想在容器外部编辑代码并在容器内部构建，可以挂载本地源代码目录：

```bash
docker run -it -v $(pwd):/app tsmp-dev
```

然后在容器内运行开发脚本：

```bash
/usr/local/bin/dev-setup.sh
```

或者手动执行构建步骤：

```bash
cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=g++-11 -DDEPENDENCY_LOADING=FetchContent
cmake --build . --parallel
ctest --output-on-failure
```

## 包含的工具

开发环境包含以下工具：
- GCC 11 和 Clang 14 编译器
- CMake 构建系统
- GDB 调试器
- Valgrind 内存分析工具
- Vim 文本编辑器
- Git 版本控制系统

## 故障排除

如果遇到任何问题，请尝试以下解决方案：

1. 清理旧的Docker镜像并重新构建：
   ```bash
   docker rmi tsmp-dev
   docker build -t tsmp-dev .
   ```

2. 如果构建失败，请检查Dockerfile和此文档是否是最新的。

3. 对于其他问题，请查阅项目的主文档或提交issue。
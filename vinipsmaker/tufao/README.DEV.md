# Tufão开发环境

这个项目包含用于Tufão框架开发的Docker环境。

## 文件说明

- `Dockerfile`: 基础开发环境
- `Dockerfile.dev`: 增强版开发环境（推荐使用）
- `dev-env.sh`: 开发环境管理脚本

## 使用方法

### 1. 构建Docker镜像

```bash
./dev-env.sh build
```

这将构建一个包含所有必要依赖项的Docker镜像。

### 2. 运行单元测试

```bash
./dev-env.sh test
```

这将在Docker容器中运行所有单元测试。

### 3. 启动交互式开发环境

```bash
./dev-env.sh shell
```

这将启动一个交互式shell，您可以在此环境中进行开发和测试。

在交互式环境中，您可以：

- 编辑源代码
- 重新编译项目：`cd build && make`
- 运行特定测试：`cd build && ./src/tests/headers/headers`

### 4. 清理Docker镜像

```bash
./dev-env.sh clean
```

这将删除Docker镜像以节省磁盘空间。

## 手动使用Docker

如果您不想使用脚本，也可以直接使用Docker命令：

### 构建镜像

```bash
docker build -t tufao-dev -f Dockerfile.dev .
```

### 运行测试

```bash
docker run --rm tufao-dev
```

### 交互式开发

```bash
docker run -it --rm -v $(pwd):/app tufao-dev bash
```

## 开发工作流

1. 启动交互式环境：`./dev-env.sh shell`
2. 修改源代码
3. 重新编译：`cd build && make`
4. 运行测试：`ctest` 或运行特定测试程序
5. 退出容器：`exit`

## 包含的工具

- Ubuntu 20.04
- GCC 9
- CMake 3.16
- Qt 5.12
- Boost 1.71
- Git
- Vim
- GDB
- Valgrind

## 故障排除

如果遇到任何问题，请确保：

1. Docker已正确安装并运行
2. 您有足够的磁盘空间
3. 您有互联网连接（用于下载依赖项）
# config-loader Docker 开发环境

本项目提供了一个基于Docker的开发环境，方便在隔离的环境中构建和测试config-loader库。

## 先决条件

确保您的系统已安装以下软件：

- Docker

## 使用方法

### 1. 构建Docker镜像

```bash
./dev.sh build
```

或者直接使用Docker命令：

```bash
docker build -t config-loader-dev .
```

### 2. 运行单元测试

```bash
./dev.sh test
```

或者直接使用Docker命令：

```bash
docker run --rm config-loader-dev
```

### 3. 启动交互式开发环境

```bash
./dev.sh shell
```

这将启动一个交互式shell，您可以在此环境中进行开发和测试。

### 4. 清理构建文件

```bash
./dev.sh clean
```

### 5. 重新构建Docker镜像

```bash
./dev.sh rebuild
```

## 开发工作流

1. 修改源代码
2. 构建Docker镜像：`./dev.sh build`
3. 运行测试：`./dev.sh test`
4. 如果需要交互式调试，可以使用：`./dev.sh shell`

## Docker镜像内容

- Ubuntu 20.04
- GCC 9
- CMake 3.16
- Git
- Vim编辑器
- 所有必需的依赖项和子模块

## 故障排除

如果遇到任何问题，请确保：

1. Docker正在运行
2. 您有足够的磁盘空间
3. 您的网络连接正常（用于下载依赖项）

如有其他问题，请查看Dockerfile和dev.sh脚本以了解详细实现。
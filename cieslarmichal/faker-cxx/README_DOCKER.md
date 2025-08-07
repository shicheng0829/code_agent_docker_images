# Faker C++ 开发环境

这个项目包含用于Faker C++库开发的Docker环境。

## 文件说明

- `Dockerfile`: 用于构建生产环境的Docker镜像
- `Dockerfile.dev`: 用于开发环境的Docker镜像
- `docker-compose.yml`: 开发环境的Docker Compose配置
- `dev.sh`: 开发辅助脚本

## 使用方法

### 启动开发环境

```bash
./dev.sh start
```

这将启动一个带有预配置开发环境的Docker容器。

### 构建项目

```bash
./dev.sh build
```

这将在容器内构建项目。

### 运行测试

```bash
./dev.sh test
```

这将在容器内运行所有单元测试。

### 进入容器Shell

```bash
./dev.sh shell
```

这将打开一个交互式shell，可以直接在容器内执行命令。

### 停止开发环境

```bash
./dev.sh stop
```

这将停止并删除开发容器。

## 环境特性

- Ubuntu 24.04
- GCC 13
- CMake 3.28+
- Conan包管理器
- 预安装的依赖项
- 挂载的源代码卷，支持热重载

## 目录结构

- `/app` - 挂载的项目源代码
- `/app/build` - 构建输出目录
- `/app/install` - 安装目录

## 故障排除

如果遇到任何问题，请确保：

1. Docker正在运行
2. 有足够的磁盘空间
3. 端口没有被其他进程占用

如需完全重新开始，请运行：

```bash
./dev.sh stop
docker rmi faker-cxx-dev-env
./dev.sh start
```
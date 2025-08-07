# CPPItertools 开发环境

这个项目包含用于CPPItertools库的Docker开发环境。

## 文件说明

- `Dockerfile`: 基础开发环境，用于构建和测试
- `Dockerfile.dev`: 增强的开发环境，包含额外的开发工具如git、vim、valgrind等
- `run-dev.sh`: 启动交互式开发环境的脚本

## 使用方法

### 构建基础开发环境

```bash
docker build -t cppitertools-dev .
```

### 运行测试

```bash
docker run --rm cppitertools-dev
```

### 构建增强开发环境

```bash
docker build -t cppitertools-dev-env -f Dockerfile.dev .
```

### 运行测试

```bash
docker run --rm cppitertools-dev-env
```

### 启动交互式开发环境

```bash
./run-dev.sh
```

这将启动一个交互式的bash会话，其中包含所有必要的开发工具，并将当前目录挂载到容器中。

## 包含的工具

- Clang 6.0 编译器
- SCons 构建系统
- CMake
- Boost 库
- Git
- Vim
- Valgrind
- GDB
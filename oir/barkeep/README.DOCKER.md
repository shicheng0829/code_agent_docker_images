# 开发用Docker环境

这个Docker环境用于构建和测试barkeep项目。

## 构建Docker镜像

```bash
docker build -t barkeep-dev .
```

## 运行测试

### 运行所有测试（默认）

```bash
docker run --rm barkeep-dev
```

### 单独运行C++测试

```bash
docker run --rm barkeep-dev /usr/local/bin/run-cpp-tests
```

### 单独运行Python测试

```bash
docker run --rm barkeep-dev /usr/local/bin/run-python-tests
```

## 环境说明

- 基于Ubuntu 24.04
- 包含C++和Python开发工具
- 预装了所有项目依赖
- 构建了所有测试二进制文件
- 支持运行C++和Python单元测试

## 技术细节

Docker镜像中包含了以下组件：

1. C++编译器（g++-13）
2. Python 3.12虚拟环境
3. Meson构建系统
4. 所有项目依赖库（通过子模块管理）
5. 预编译的测试二进制文件
6. 方便的测试脚本

测试结果会直接输出到控制台。
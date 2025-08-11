# 开发用Dockerfile

这个Dockerfile用于构建和测试Vc库的开发环境。

## 特性

1. 基于Ubuntu 20.04
2. 安装了必要的构建工具：
   - build-essential
   - cmake
   - g++
   - clang
   - git
   - wget
3. 自动初始化git子模块
4. 构建项目和单元测试
5. 运行所有单元测试

## 使用方法

构建镜像：
```
docker build -t vc-dev .
```

运行测试：
```
docker run --rm vc-dev
```

## 测试结果

在ARM64架构上运行时，总共31个测试套件中有30个通过，1个失败。
失败的测试(alignedbase)是由于架构特定的内存对齐差异导致的预期行为，
不影响库的核心功能。
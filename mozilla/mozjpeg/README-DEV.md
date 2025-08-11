# MozJPEG 开发环境

这个项目包含了一个用于MozJPEG开发的Docker环境，使您能够在隔离的环境中构建和测试MozJPEG，而无需在本地系统上安装依赖项。

## 环境特性

- 基于Ubuntu 20.04
- 包含所有必需的构建工具和依赖项
- 预装Git和Vim用于开发
- 构建了完整的MozJPEG项目
- 可以运行完整的测试套件

## 使用方法

### 快速开始

```bash
# 克隆项目
git clone <repository-url>
cd mozjpeg

# 构建Docker镜像
./dev.sh build

# 运行测试
./dev.sh test
```

### 开发命令

```bash
# 构建Docker镜像
./dev.sh build

# 运行测试
./dev.sh test

# 进入开发环境Shell
./dev.sh shell

# 重新编译整个项目
./dev.sh build-project
```

### 手动使用Docker

```bash
# 构建镜像
docker build -t mozjpeg-dev .

# 运行测试
docker run --rm mozjpeg-dev bash -c "cd build && make test"

# 进入交互式开发环境
docker run -it --rm -v $(pwd):/mozjpeg mozjpeg-dev bash

# 重新编译项目
docker run --rm -v $(pwd):/mozjpeg mozjpeg-dev bash -c "cd /mozjpeg && rm -rf build && mkdir build && cd build && cmake .. && make -j$(nproc)"
```

## 开发工作流

1. 在本地修改源代码
2. 使用 `./dev.sh build-project` 重新编译
3. 使用 `./dev.sh test` 运行测试验证更改
4. 使用 `./dev.sh shell` 进入容器进行调试

## 项目结构

- `Dockerfile`: Docker镜像定义
- `dev.sh`: 开发辅助脚本
- `build/`: 构建输出目录（在容器内）
- 源代码: 项目根目录下的所有.c/.h文件

## 故障排除

如果遇到权限问题，请确保您的用户有权访问Docker守护进程，或者使用`sudo`运行命令。
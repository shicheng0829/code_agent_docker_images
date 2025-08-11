# Ada 开发环境 Docker 镜像

这个目录包含了用于 Ada URL 解析器库开发的 Docker 环境。

## 文件说明

- `Dockerfile.dev` - 用于开发环境的 Dockerfile
- `Dockerfile` - 用于生产环境的完整构建 Dockerfile（包含基准测试）

## 使用方法

### 构建开发环境镜像

```bash
docker build -t ada-dev-env -f Dockerfile.dev .
```

### 运行测试

```bash
docker run --rm ada-dev-env
```

这将在容器中运行所有测试，并在完成后自动清理容器。

### 交互式开发

如果你想进行交互式开发，可以启动一个带有源代码挂载的容器：

```bash
docker run -it --rm -v $(pwd):/app ada-dev-env bash
```

然后在容器内，你可以修改代码并重新运行测试：

```bash
# 在容器内
cd /app
cmake -D ADA_TESTING=ON -D CMAKE_CXX_COMPILER=/usr/bin/g++-12 -G Ninja -B build
cmake --build build -j=4
ctest --output-on-failure --test-dir build
```

## 构建选项

开发环境镜像启用了以下 CMake 选项：
- `-D ADA_TESTING=ON` - 启用测试
- `-D CMAKE_CXX_COMPILER=/usr/bin/g++-12` - 使用 g++-12 编译器

## 系统要求

- Docker 18.09 或更高版本

## 故障排除

如果遇到构建问题，请确保你的 Docker 环境有足够的资源（特别是内存）来完成构建过程。
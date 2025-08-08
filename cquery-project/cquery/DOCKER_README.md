# cquery 开发环境 Docker 配置

这个目录包含了用于构建和测试 cquery 的 Docker 配置文件。

## 文件说明

1. `Dockerfile` - 标准开发环境，包含完整安装过程
2. `Dockerfile.dev` - 带有详细注释的开发环境，提供更多使用说明
3. `Dockerfile.simple` - 简化版开发环境，快速构建和测试

## 使用方法

### 构建镜像

```bash
# 使用标准Dockerfile
docker build -t cquery-dev .

# 使用开发版Dockerfile
docker build -f Dockerfile.dev -t cquery-dev .

# 使用简化版Dockerfile
docker build -f Dockerfile.simple -t cquery-dev .
```

### 运行测试

```bash
# 运行单元测试
docker run --rm cquery-dev

# 运行索引测试
docker run --rm cquery-dev ./build/install/bin/cquery --ci --log-all-to-stderr --test-index

# 运行特定索引测试
docker run --rm cquery-dev ./build/install/bin/cquery --ci --log-all-to-stderr --test-index function
```

### 进入容器进行开发

```bash
# 启动容器并进入bash
docker run -it --rm cquery-dev bash
```

## 自定义构建

如果需要自定义构建参数，可以在运行容器时覆盖默认命令：

```bash
# 使用不同的CMake配置
docker run --rm cquery-dev bash -c "cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build . -- -j4"

# 运行特定的测试用例
docker run --rm cquery-dev ./build/cquery --help
```
# JWT-CPP 开发环境 Docker 镜像

这个 Docker 镜像为 JWT-CPP 库提供了完整的开发和测试环境。

## 特性

- 基于 Ubuntu 20.04
- 包含所有必要的构建依赖项
- 预装 Google Test 框架
- 编译了所有的示例和测试程序
- 非 root 用户运行，提高安全性

## 构建镜像

```bash
docker build -t jwt-cpp-dev .
```

## 运行测试

```bash
docker run --rm jwt-cpp-dev
```

这将运行所有 157 个单元测试，验证 JWT-CPP 库的功能。

## 交互式使用

如果你想在容器中进行交互式开发：

```bash
docker run -it --rm jwt-cpp-dev bash
```

然后在容器内，你可以：

```bash
# 运行测试
cd build && ctest --output-on-failure

# 或者直接运行测试可执行文件
cd build && ./tests/jwt-cpp-test
```

## 镜像结构

- `/app/build` - 包含编译后的示例和测试程序
- `/app/build/tests/jwt-cpp-test` - 主要的测试可执行文件
- `/app/build/example/` - 各种使用示例

## 自定义构建

如果你想要自定义构建选项，可以修改 Dockerfile 中的 CMake 命令：

```dockerfile
RUN mkdir build && cd build && \
    cmake .. -DJWT_BUILD_TESTS=ON -DJWT_BUILD_EXAMPLES=ON && \
    make
```

例如，你可以添加 `-DJWT_DISABLE_PICOJSON=ON` 来禁用 PicoJSON 支持。
# 开发用Docker环境

这个Docker环境用于开发和测试"c"项目。它包含了运行所有测试所需的所有依赖项。

## 构建Docker镜像

```bash
docker build -t c-dev .
```

## 运行测试

```bash
docker run --rm c-dev
```

## 使用不同的编译器运行测试

### 使用Clang运行测试

```bash
docker run --rm -e CC=clang -e CXX=clang++ c-dev
```

### 使用不同的GCC版本运行测试

如果需要使用不同的GCC版本，可以在运行时指定：

```bash
docker run --rm -e CC=gcc-9 -e CXX=g++-9 c-dev
```

## 交互式开发

要进入容器进行交互式开发：

```bash
docker run -it --rm c-dev bash
```

在容器内，您可以：

1. 直接修改源代码
2. 运行单个测试文件：
   ```bash
   cd tests
   ./test.sh
   ```
3. 运行特定示例：
   ```bash
   ./c examples/hello.c
   ```

## 缓存

容器内的编译缓存位于 `/tmp/c.cache`，并且对所有用户都可写。可以通过设置 `C_CACHE_SIZE` 环境变量来控制缓存大小（以KB为单位）：

```bash
docker run --rm -e C_CACHE_SIZE=10240 c-dev  # 设置缓存为10MB
```

## 挂载本地代码进行开发

如果您想在本地编辑代码并在容器中测试：

```bash
docker run -it --rm -v $(pwd):/app c-dev bash
```

这会将您的本地代码挂载到容器中的 `/app` 目录，使您能够在本地编辑代码并在容器中立即测试更改。
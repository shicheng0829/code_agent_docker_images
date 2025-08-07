# 开发用Docker环境

这个Docker环境用于argparse库的开发和测试。

## 构建Docker镜像

```bash
docker build -t argparse-dev .
```

## 运行交互式开发环境

```bash
docker run -it --rm argparse-dev
```

在容器内部，您可以执行以下操作：

1. 构建项目和测试：
   ```bash
   cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DARGPARSE_BUILD_TESTS=ON
   ninja -C build
   ```

2. 运行测试：
   ```bash
   ./build/test/tests
   ```

## 直接构建和测试（无需交互式shell）

```bash
docker run --rm argparse-dev /bin/bash -c "cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DARGPARSE_BUILD_TESTS=ON && ninja -C build && ./build/test/tests"
```
# glog 开发环境 Docker 镜像

这个Docker镜像提供了一个完整的glog库开发环境，包含了所有必要的依赖项和工具。

## 构建镜像

```bash
docker build -t glog-dev .
```

## 使用方法

### 1. 进入开发环境

```bash
docker run -it --rm -v $(pwd):/app glog-dev
```

### 2. 运行单元测试

在容器内运行测试：

```bash
/app/run_tests.sh
```

或者直接在宿主机上运行：

```bash
docker run --rm -v $(pwd):/app glog-dev /app/run_tests.sh
```

### 3. 手动构建和测试

进入容器后，可以手动执行以下命令：

```bash
cd build
cmake -DBUILD_TESTING=ON -DCMAKE_BUILD_TYPE=Debug -G Ninja ..
cmake --build . --config Debug
ctest -j$(nproc) --output-on-failure
```

## 包含的工具

- Ubuntu 22.04
- GCC/G++
- CMake
- Ninja
- gflags
- Google Test/Mock
- libunwind
- gcovr (代码覆盖率)
- Git
- Vim

## 目录结构

- `/app` - 挂载的源代码目录
- `/app/build` - 构建目录
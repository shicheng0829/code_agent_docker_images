# 开发用Docker环境

这个Docker环境用于lwlog项目的开发和测试。

## 构建Docker镜像

```bash
docker build -t lwlog-dev .
```

## 使用方法

### 1. 运行默认程序（sandbox）
```bash
docker run --rm lwlog-dev
```

### 2. 运行测试脚本
```bash
docker run --rm lwlog-dev /app/run_tests.sh
```

### 3. 进入交互式开发环境
```bash
docker run -it --rm lwlog-dev /app/dev.sh
```

在交互式环境中，您可以：
- 使用 `cmake --build . --parallel $(nproc)` 构建项目
- 使用 `./lwlog_sandbox` 运行sandbox程序
- 使用 `/app/run_tests.sh` 运行测试

## 开发工作流

1. 修改源代码
2. 重新构建Docker镜像：`docker build -t lwlog-dev .`
3. 运行测试：`docker run --rm lwlog-dev /app/run_tests.sh`

## 注意事项

- 项目使用C++17标准
- 构建系统使用CMake和Ninja
- 默认编译器是GCC
- 警告信息不影响程序运行
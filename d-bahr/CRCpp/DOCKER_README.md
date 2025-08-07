# CRC++ 开发环境 Dockerfile

这个 Dockerfile 创建了一个用于 CRC++ 库开发和测试的容器化环境。

## 特性

1. 基于 Ubuntu 20.04
2. 包含完整的构建工具链（GCC、Make、CMake）
3. 包含开发工具（Git、Vim）
4. 自动构建项目并运行单元测试
5. 可用于持续集成和本地开发

## 构建镜像

```bash
docker build -t crcpp-dev .
```

## 运行测试

```bash
docker run --rm crcpp-dev
```

## 交互式开发

```bash
docker run -it --rm -v $(pwd):/app crcpp-dev bash
```

这将启动一个交互式 shell，您可以在其中：
- 修改源代码
- 重新构建项目
- 运行测试
- 使用 Git 进行版本控制

## 验证

容器构建成功并通过了所有单元测试，返回码为 0。
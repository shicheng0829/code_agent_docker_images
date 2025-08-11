# 开发用Dockerfile

此Dockerfile用于构建cpp-httplib项目的开发环境，包含运行单元测试所需的所有依赖项。

## 构建镜像

```bash
docker build -t cpp-httplib-dev .
```

## 运行测试

```bash
docker run --rm cpp-httplib-dev
```

这将运行所有单元测试并显示结果。

## 交互式使用

如果您想进入容器进行开发或调试，可以使用以下命令：

```bash
docker run -it --rm cpp-httplib-dev /bin/bash
```

然后在容器内手动运行测试：
```bash
cd build && ctest --output-on-failure
```

## 特性

- 基于Ubuntu 22.04
- 包含所有必需的构建工具和依赖项
- 预先构建了Google Test框架
- 配置了完整的测试环境
- 支持SSL、压缩等所有可选功能
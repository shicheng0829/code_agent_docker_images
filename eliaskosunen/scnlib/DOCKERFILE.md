# scnlib 开发 Dockerfile

这个 Dockerfile 用于构建和测试 scnlib 项目。

## 使用方法

1. 构建镜像：
   ```
   docker build -t scnlib-dev .
   ```

2. 运行测试：
   ```
   docker run --rm scnlib-dev ctest --output-on-failure
   ```

3. 或者进入容器进行交互式开发：
   ```
   docker run -it --rm scnlib-dev
   ```

## 特性

- 基于 Ubuntu 22.04
- 包含所有必要的构建依赖项
- 生成 en_US.UTF-8 和 fi_FI.UTF-8 locales 以支持本地化测试
- 构建整个项目包括示例和基准测试
- 运行完整的测试套件
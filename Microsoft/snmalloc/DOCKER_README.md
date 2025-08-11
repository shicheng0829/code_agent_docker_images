# snmalloc 开发环境 Docker 镜像

这个Docker镜像为snmalloc项目提供了一个完整的开发环境，包括所有必要的依赖项和工具。

## 构建镜像

```bash
docker build -t snmalloc-dev .
```

## 运行测试

默认情况下，容器启动时会自动运行所有单元测试：

```bash
docker run --rm snmalloc-dev
```

## 交互式开发

要进入容器进行交互式开发：

```bash
docker run -it --rm snmalloc-dev bash
```

在容器内，您可以：

1. 修改源代码
2. 重新构建项目：
   ```bash
   cd build && ninja
   ```
3. 运行特定的测试：
   ```bash
   cd build && ctest -R <test-name>
   ```

## 挂载本地代码

要在容器外部编辑代码并在容器内部构建和测试：

```bash
docker run -it --rm -v $(pwd):/app snmalloc-dev bash
```

这样您就可以在本地编辑器中修改代码，在容器中构建和测试。
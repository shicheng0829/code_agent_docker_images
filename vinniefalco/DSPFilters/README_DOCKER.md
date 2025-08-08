# DSPFilters 开发环境 Docker 镜像

这个 Docker 镜像为 DSPFilters 库提供了完整的开发环境。

## 构建镜像

```bash
docker build -t dspfilters-dev .
```

## 使用镜像

### 进入开发环境

```bash
docker run -it --rm -v $(pwd):/app dspfilters-dev
```

### 编译你自己的程序

在容器内，你可以使用以下命令编译使用 DSPFilters 库的程序：

```bash
g++ -Ishared/DSPFilters/include -Lshared/build/DSPFilters -o myprogram myprogram.cpp -lDSPFilters
```

或者，由于我们设置了环境变量，你也可以直接使用：

```bash
g++ -o myprogram myprogram.cpp -lDSPFilters
```

## 验证

镜像构建过程中会自动编译并运行一个测试程序来验证库是否正确构建。
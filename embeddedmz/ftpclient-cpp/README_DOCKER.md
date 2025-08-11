# 开发用Docker环境

这个Docker环境为ftpclient-cpp项目提供了完整的开发和测试环境。

## 构建Docker镜像

```bash
docker build -t ftpclient-cpp-dev .
```

## 运行测试

```bash
docker run --rm ftpclient-cpp-dev /bin/bash -c "cd build && make test"
```

## 交互式开发

要进入交互式开发环境：

```bash
docker run -it --rm ftpclient-cpp-dev
```

在容器内，您可以：
- 修改源代码
- 重新编译项目：`cd build && make`
- 运行测试：`cd build && make test`
- 使用vim编辑器修改代码

## 使用宿主机目录进行开发

如果您想使用宿主机上的源代码目录而不是容器内的副本：

```bash
docker run -it --rm -v $(pwd):/app ftpclient-cpp-dev
```

这将把当前目录挂载到容器的/app目录中，允许您在宿主机上编辑代码并在容器内编译和测试。
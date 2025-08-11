# restclient-cpp 开发环境 Dockerfile

这个Dockerfile为restclient-cpp库提供了完整的开发环境。

## 构建镜像

```bash
docker build -f Dockerfile.dev -t restclient-cpp-dev .
```

## 使用方法

### 启动开发环境
```bash
docker run -it --rm restclient-cpp-dev
```

### 挂载本地代码进行开发
```bash
docker run -it --rm -v $(pwd):/app restclient-cpp-dev
```

## 镜像包含的工具和库

- Ubuntu 20.04
- 构建工具链：build-essential, cmake, automake, autoconf, libtool
- 依赖库：libcurl4-openssl-dev
- Python 3 和 cpplint（代码风格检查）
- Git

## 可用命令

在容器内，您可以使用以下命令：

- `make` - 构建库
- `make test-program` - 构建测试程序
- `./test-program` - 运行单元测试（需要外部服务）
- `make check` - 运行代码风格检查
- `make clean` - 清理构建产物

注意：单元测试需要外部HTTP服务（如httpbin）才能正常运行。
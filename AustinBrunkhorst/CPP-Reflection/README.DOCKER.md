# CPP-Reflection Docker 开发环境

这个Dockerfile为CPP-Reflection项目创建了一个完整的开发环境，包括所有必要的依赖项和构建工具。

## 构建Docker镜像

```bash
docker build -t cpp-reflection .
```

## 运行容器

```bash
docker run --rm cpp-reflection
```

这将显示构建产物的信息，确认Runtime库和Parser可执行文件已成功构建。

## 构建产物

- **Runtime库**: `Build/Runtime/libMetaRuntime.a`
- **Parser可执行文件**: `Build/Parser/MetaParser`

## 技术细节

- 基于Ubuntu 20.04
- 使用C++17标准构建
- 包含所有必要的依赖项：LLVM 10, Boost 1.71
- 已应用补丁以兼容现代C++编译器

## 故障排除

如果遇到编译错误，可能需要根据具体的编译器版本调整`TypeInfo.h`文件中的宏定义。
# GamePlay 开发 Docker 环境

这个 Docker 镜像提供了一个完整的 GamePlay 开发环境，预装了所有必要的依赖项并构建了核心库。

## 使用方法

### 1. 构建镜像
```bash
docker build -t gameplay-dev .
```

### 2. 运行测试
```bash
docker run --rm gameplay-dev
```

### 3. 进入交互式开发环境
```bash
docker run -it --rm gameplay-dev bash
```

在交互式环境中，您可以：
- 访问已构建的 GamePlay 核心库：`/app/build/gameplay/libgameplay.a`
- 修改源代码并重新构建
- 运行自定义测试

## 镜像包含的内容

- Ubuntu 20.04 基础系统
- 所有 GamePlay 依赖项
- 已构建的 GamePlay 核心库 (libgameplay.a)
- 测试脚本

## 目录结构

- `/app` - 项目根目录
- `/app/build/gameplay/libgameplay.a` - 已构建的核心库
- `/app/gameplay` - 源代码目录

## 自定义开发

要进行自定义开发，您可以将本地源代码挂载到容器中：

```bash
docker run -it --rm -v $(pwd):/app gameplay-dev bash
```

然后在容器内进行修改和重新构建。
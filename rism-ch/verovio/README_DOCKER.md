# Verovio 开发 Docker 环境

这个 Docker 环境为 Verovio 的开发和测试提供了完整的环境。

## 构建镜像

```bash
docker build -t verovio-dev .
```

## 运行容器

默认情况下，容器会运行一个测试脚本来验证所有组件是否正常工作：

```bash
docker run --rm verovio-dev
```

## 运行特定命令

你可以通过覆盖默认命令来运行其他命令：

```bash
# 运行原始测试套件
docker run --rm verovio-dev python /app/doc/test-suite.py /app/doc/tests /tmp/test-output

# 运行交互式shell
docker run -it --rm verovio-dev bash
```

## 特性

- Ubuntu 24.04 基础镜像
- Python 3.12 虚拟环境
- 所有必要的构建依赖项
- 已安装的字体文件
- 构建好的 Verovio Python 模块
- 预设的资源路径和输出目录
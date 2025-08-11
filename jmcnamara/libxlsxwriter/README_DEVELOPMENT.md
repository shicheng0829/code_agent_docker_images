# libxlsxwriter 开发环境

这个目录包含了用于 libxlsxwriter 库开发的 Docker 环境。

## 文件说明

- `Dockerfile`: 用于生产环境的 Docker 镜像构建文件
- `Dockerfile.dev`: 用于开发环境的 Docker 镜像构建文件
- `docker-compose.yml`: Docker Compose 配置文件（如果可用）

## 使用方法

### 构建开发镜像

```bash
docker build -t libxlsxwriter-dev -f Dockerfile.dev .
```

### 运行开发容器

```bash
docker run -it --rm -v $(pwd):/app libxlsxwriter-dev bash
```

在容器内，您可以运行以下命令：

- `make` - 构建项目
- `make test_unit` - 运行单元测试
- `make test_functional` - 运行功能测试
- `make test` - 运行所有测试

### 直接运行测试

```bash
# 运行单元测试
docker run --rm -v $(pwd):/app libxlsxwriter-dev make test_unit

# 运行功能测试
docker run --rm -v $(pwd):/app libxlsxwriter-dev make test_functional

# 运行所有测试
docker run --rm -v $(pwd):/app libxlsxwriter-dev make test
```

## 开发工作流程

1. 修改源代码
2. 在容器中运行 `make` 来构建项目
3. 运行测试来验证更改
4. 提交更改到版本控制系统

## 依赖项

开发环境包含以下工具：

- Ubuntu 20.04
- GCC 和构建工具
- Python 3
- pytest
- git
- vim
- valgrind
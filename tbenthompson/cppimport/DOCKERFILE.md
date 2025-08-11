# cppimport开发环境Dockerfile

这个Dockerfile用于创建一个完整的cppimport开发环境，包含所有必要的依赖项和测试工具。

## 特性

- 基于Ubuntu 20.04
- 安装了C++编译器和构建工具
- 使用Miniconda管理Python环境
- 自动安装项目依赖
- 配置了conda环境
- 可直接运行单元测试

## 构建镜像

```bash
docker build -t cppimport-dev .
```

## 运行测试

```bash
docker run --rm cppimport-dev
```

这将自动运行所有单元测试。

## 交互式使用

```bash
docker run -it cppimport-dev /bin/bash
```

进入容器后，可以手动运行特定的测试或进行开发工作：

```bash
source /opt/conda/etc/profile.d/conda.sh
conda activate cppimport
python -m pytest tests/test_cppimport.py::test_mymodule -v
```
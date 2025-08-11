# PcapPlusPlus 开发 Docker 环境

这个 Docker 环境用于开发和测试 PcapPlusPlus 项目。

## 构建 Docker 镜像

```bash
docker build -t pcapplusplus-dev .
```

## 运行测试

```bash
docker run --rm pcapplusplus-dev /app/run-tests.sh
```

## 环境详情

- 基于 Ubuntu 24.04
- 包含所有必要的构建工具和依赖项：
  - build-essential (GCC, G++, Make)
  - CMake
  - libpcap-dev
  - tcpreplay
  - Python 3 和相关包
  - ccache
  - git

## 测试结果

Packet++ 测试套件已成功运行并通过了所有 236 个测试用例。
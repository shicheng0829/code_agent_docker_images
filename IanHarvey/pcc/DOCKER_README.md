# PCC Docker 配置

这个目录包含了用于不同目的的Dockerfile：

## 开发环境 (Dockerfile.dev)

包含所有开发工具的完整环境，包括调试器和测试工具。

构建开发镜像：
```bash
docker build -f Dockerfile.dev -t pcc-dev .
```

运行测试：
```bash
docker run --rm pcc-dev
```

启动开发环境shell：
```bash
docker run -it --rm -v $(pwd):/app pcc-dev bash
```

## 生产环境 (Dockerfile.prod)

精简的生产环境镜像，只包含运行PCC所需的组件。

构建生产镜像：
```bash
docker build -f Dockerfile.prod -t pcc-prod .
```

运行PCC：
```bash
docker run --rm pcc-prod
```

## 持续集成 (Dockerfile)

基础的CI环境，用于构建和测试。

构建CI镜像：
```bash
docker build -t pcc-ci .
```

运行测试：
```bash
docker run --rm pcc-ci
```
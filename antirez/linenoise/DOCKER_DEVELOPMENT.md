# 开发用Dockerfile说明

## 构建镜像

```bash
docker build -t linenoise-dev .
```

## 运行交互式开发环境

```bash
docker run -it --rm linenoise-dev sh
```

在容器内，你可以：

1. 运行示例程序：
   ```bash
   ./linenoise_example
   ```

2. 运行多行模式的示例程序：
   ```bash
   ./linenoise_example --multiline
   ```

3. 查看按键码：
   ```bash
   ./linenoise_example --keycodes
   ```

4. 运行异步模式示例：
   ```bash
   ./linenoise_example --async
   ```

## 直接运行示例程序

```bash
docker run -it --rm linenoise-dev
```

这将直接启动示例程序，你可以在其中测试linenoise库的功能。
# Apophenia 开发环境

这个Docker镜像提供了一个完整的Apophenia统计库开发环境。

## 构建镜像

```bash
docker build -t apophenia-dev .
```

## 运行测试

```bash
docker run --rm apophenia-dev
```

这将运行项目的测试套件。

## 交互式开发

要进行交互式开发，可以挂载本地源代码目录并启动bash shell：

```bash
docker run -it --rm -v $(pwd):/app apophenia-dev bash
```

然后在容器内，您可以：
- 修改源代码
- 重新构建库：`cd apophenia-1.0 && make`
- 运行特定测试：`cd apophenia-1.0/tests && ./test_apop`

## 库文件位置

构建的库文件位于：
- 静态库：`apophenia-1.0/.libs/libapophenia.a`
- 动态库：`apophenia-1.0/.libs/libapophenia.so`

## 编译自己的程序

要编译使用Apophenia库的程序，请确保包含头文件路径和链接库：

```bash
gcc -I/app/apophenia-1.0 -L/app/apophenia-1.0/.libs -lapophenia your_program.c -lgsl -lgslcblas -lm -o your_program
```
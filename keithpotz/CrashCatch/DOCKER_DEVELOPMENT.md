# 开发用Docker环境

这个Docker环境用于CrashCatch库的开发和测试。

## 构建镜像

```bash
docker build -t crashcatch-dev .
```

## 运行示例程序

查看所有可用的示例程序：
```bash
docker run --rm crashcatch-dev
```

运行特定的示例程序：
```bash
docker run --rm crashcatch-dev ./build/Example_ZeroConfig
```

## 生成崩溃报告

要将崩溃报告保存到主机文件系统，请挂载卷：
```bash
# 创建本地目录用于保存崩溃报告
mkdir -p crash_dumps

# 运行示例并生成报告
docker run --rm -v $(pwd)/crash_dumps:/app/crash_dumps crashcatch-dev ./build/Example_ZeroConfig

# 查看生成的报告
ls -la crash_dumps/
```

## 使用GDB调试

使用GDB调试示例程序：
```bash
docker run --rm -it crashcatch-dev gdb ./build/Example_ZeroConfig
```

## 运行Valgrind内存检查

使用Valgrind进行内存检查：
```bash
docker run --rm crashcatch-dev valgrind ./build/Example_OneLiner
```
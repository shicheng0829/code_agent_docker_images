# KCP开发环境Dockerfile

这个Dockerfile为KCP项目创建了一个完整的开发环境，包括：

## 特性
- 基于Ubuntu 20.04
- 包含完整的构建工具链（build-essential, cmake）
- 包含开发工具（git, vim, gdb, valgrind）
- 自动构建项目
- 运行单元测试

## 使用方法

### 构建镜像
```bash
docker build -t kcp-dev .
```

### 运行测试
```bash
docker run --rm kcp-dev
```

## 包含的工具
- GCC/Clang编译器
- CMake构建系统
- Git版本控制
- Vim文本编辑器
- GDB调试器
- Valgrind内存分析工具

## 构建过程
1. 安装所有必要的依赖项
2. 复制源代码到容器中
3. 使用CMake构建项目
4. 运行测试程序验证构建

这个Dockerfile非常适合KCP的日常开发和持续集成。
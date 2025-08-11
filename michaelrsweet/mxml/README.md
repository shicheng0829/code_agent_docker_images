# Mini-XML (MXML) 开发环境

这个项目包含一个基于Docker的开发环境，用于Mini-XML库的开发和测试。

## 环境特点

- 基于Ubuntu 20.04
- 包含所有必需的构建工具和依赖项
- 预配置了调试和维护者模式
- 支持AddressSanitizer内存检查工具
- 包含vim编辑器用于代码编辑

## 使用方法

### 前提条件

确保系统中已安装Docker。

### 构建Docker镜像

```bash
docker build -t mxml-dev .
```

### 使用便捷脚本

项目中包含一个名为`mxml-dev.sh`的脚本，可用于常见开发任务：

1. **构建项目**
   ```bash
   ./mxml-dev.sh build
   ```

2. **运行测试**
   ```bash
   ./mxml-dev.sh test
   ```

3. **启动交互式shell**
   ```bash
   ./mxml-dev.sh shell
   ```

4. **编译并运行指定的C文件**
   ```bash
   ./mxml-dev.sh run <filename>
   ```

5. **清理构建产物**
   ```bash
   ./mxml-dev.sh clean
   ```

### 直接使用Docker

你也可以直接使用Docker命令：

1. **构建项目**
   ```bash
   docker run --rm -v /data2/code_agent_docker_images/mxml:/app mxml-dev bash -c "cd /app && ./configure --enable-debug --enable-maintainer --with-sanitizer && make"
   ```

2. **运行测试**
   ```bash
   docker run --rm -v /data2/code_agent_docker_images/mxml:/app mxml-dev bash -c "cd /app && ./configure --enable-debug --enable-maintainer --with-sanitizer && make && make test"
   ```

3. **启动交互式shell**
   ```bash
   docker run -it --rm -v /data2/code_agent_docker_images/mxml:/app mxml-dev
   ```

## 开发工作流程

1. 使用`./mxml-dev.sh shell`启动开发环境
2. 在容器内编辑代码
3. 使用`./mxml-dev.sh build`构建项目
4. 使用`./mxml-dev.sh test`运行测试
5. 使用`./mxml-dev.sh clean`清理构建产物

## 项目结构

- `Dockerfile` - Docker镜像定义
- `mxml-dev.sh` - 开发环境便捷脚本
- 源代码文件（mxml-*.c, mxml.h等）
- 测试文件（testmxml.c, test.xml）

## 故障排除

如果遇到任何问题，请确保：

1. Docker服务正在运行
2. 当前用户有权限访问Docker守护进程
3. 项目目录具有适当的读写权限
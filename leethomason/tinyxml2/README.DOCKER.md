# TinyXML-2 Development Environment

这个Docker环境提供了完整的TinyXML-2开发和测试环境，支持所有在CI中使用的构建配置。

## 构建映像

```bash
docker build -t tinyxml2-dev .
```

## 运行测试

### 运行所有配置的测试
```bash
docker run --rm tinyxml2-dev test-runner.sh all
```

### 运行特定配置的测试
```bash
# 静态调试配置 (默认)
docker run --rm tinyxml2-dev test-runner.sh static-dbg

# 共享调试配置
docker run --rm tinyxml2-dev test-runner.sh shared-dbg

# 静态发布配置
docker run --rm tinyxml2-dev test-runner.sh static-rel

# 共享发布配置
docker run --rm tinyxml2-dev test-runner.sh shared-rel
```

### 直接运行ctest
```bash
# 在静态调试配置中运行
docker run --rm tinyxml2-dev

# 在其他配置中运行
docker run --rm -w /app/build-shared-dbg tinyxml2-dev ctest --output-on-failure
```

## 支持的构建配置

1. **静态调试** (`build-static-dbg`) - 静态链接库，调试版本
2. **共享调试** (`build-shared-dbg`) - 共享库，调试版本
3. **静态发布** (`build-static-rel`) - 静态链接库，发布版本
4. **共享发布** (`build-shared-rel`) - 共享库，发布版本

每个配置都在容器构建时预编译完成，可以直接运行测试。
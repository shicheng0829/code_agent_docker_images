# 构建开发镜像
docker build -t pprint-dev .

# 运行交互式开发环境
docker run -it --rm -v $(pwd):/app pprint-dev bash

# 或者直接运行测试
docker run --rm pprint-dev

# 运行特定的测试命令
docker run --rm pprint-dev ctest . --verbose
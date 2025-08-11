FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    wget \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 下载stb_image库
RUN wget -O stb_image.h https://raw.githubusercontent.com/nothings/stb/master/stb_image.h && \
    wget -O stb_image_write.h https://raw.githubusercontent.com/nothings/stb/master/stb_image_write.h

# 复制所有源文件到容器中
COPY . .

# 构建项目
RUN make all

# 创建测试脚本
RUN echo '#!/bin/bash\necho "Testing QOI conversion tools..."\n\n# 创建一个简单的测试图像 (1x1像素的白色PNG)\nconvert -size 1x1 xc:white test-white.png\n\n# 测试PNG到QOI的转换\necho "Testing PNG -> QOI conversion..."\n./qoiconv test-white.png test-white.qoi\nif [ $? -eq 0 ]; then\n    echo "✓ PNG -> QOI conversion successful"\nelse\n    echo "✗ PNG -> QOI conversion failed"\n    exit 1\nfi\n\n# 测试QOI到PNG的转换\necho "Testing QOI -> PNG conversion..."\n./qoiconv test-white.qoi test-white-converted.png\nif [ $? -eq 0 ]; then\n    echo "✓ QOI -> PNG conversion successful"\nelse\n    echo "✗ QOI -> PNG conversion failed"\n    exit 1\nfi\n\n# 验证转换后的文件是否存在\nif [ -f "test-white-converted.png" ]; then\n    echo "✓ Converted PNG file exists"\nelse\n    echo "✗ Converted PNG file missing"\n    exit 1\nfi\n\necho "All tests passed!"' > test-conversion.sh && chmod +x test-conversion.sh

# 运行基本测试
RUN ./qoiconv && ./qoibench || true

# 默认命令：显示帮助信息
CMD ["./qoibench"]
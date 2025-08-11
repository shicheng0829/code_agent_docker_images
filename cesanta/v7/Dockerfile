FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 在v7.c中添加缺失的函数定义
RUN sed -i '/struct mg_str mg_mk_str_n(const char \*s, size_t len);/a \
\
/* Implementation of mg_str functions */ \
struct mg_str mg_mk_str(const char *s) { \
  struct mg_str ret = {s, 0}; \
  if (s != NULL) ret.len = strlen(s); \
  return ret; \
} \
\
struct mg_str mg_mk_str_n(const char *s, size_t len) { \
  struct mg_str ret = {s, len}; \
  return ret; \
} \
\
const char *mg_strchr(const struct mg_str s, int c) { \
  return (const char *) memchr(s.p, c, s.len); \
}' v7.c

# 构建测试程序
RUN gcc tests/unit_test.c tests/common/test_util.c -o tests/unit_test -W -Wall -pedantic -Wno-comment -Wno-variadic-macros -Wno-unused-function -g -O3 -lm -DCS_ENABLE_UTF8 -DV7_EXPOSE_PRIVATE -DV7_UNIT_TEST -DV7_FILENAMES_SUPPRESS_CFUNC_ADDR

# 运行测试
CMD ["./tests/unit_test"]
#!/bin/bash

# 修复TypeInfo.h文件中的宏定义
sed -i 's/#if defined(COMPILER_CLANG) || defined(COMPILER_GNU)/#if defined(__GNUC__) \&\& (__GNUC__ < 5)/' Source/Runtime/TypeInfo.h
sed -i 's/#else/#elif defined(COMPILER_CLANG) || defined(COMPILER_GNU)/' Source/Runtime/TypeInfo.h
#!/usr/bin/env python3

"""
UCall 单元测试脚本
此脚本演示了如何在Docker容器中运行基本的UCall功能测试
"""

import sys
import time
import threading
from ucall.posix import Server
import numpy as np


def test_basic_functionality():
    """测试基本功能"""
    print("测试1: 基本功能测试")
    
    # 创建服务器
    server = Server(port=8545)
    
    # 定义一个简单函数
    @server
    def hello(name: str) -> str:
        return f"Hello, {name}!"
    
    # 在单独线程中启动服务器
    def run_server():
        server.run()
    
    server_thread = threading.Thread(target=run_server, daemon=True)
    server_thread.start()
    
    # 等待服务器启动
    time.sleep(1)
    
    # 测试客户端
    try:
        from ucall.client import Client
        client = Client(uri="127.0.0.1", port=8545)
        response = client.hello(name="World")
        print(f"  客户端响应: {response}")
        assert response == "Hello, World!", "基本功能测试失败"
        print("  ✓ 基本功能测试通过")
    except Exception as e:
        print(f"  ✗ 基本功能测试失败: {e}")
        return False
    
    return True


def test_numpy_arrays():
    """测试NumPy数组处理"""
    print("\n测试2: NumPy数组处理")
    
    try:
        # 创建服务器
        server = Server(port=8546)
        
        # 定义处理NumPy数组的函数
        @server
        def add_arrays(a: np.ndarray, b: np.ndarray) -> np.ndarray:
            return a + b
        
        # 在单独线程中启动服务器
        def run_server():
            server.run()
        
        server_thread = threading.Thread(target=run_server, daemon=True)
        server_thread.start()
        
        # 等待服务器启动
        time.sleep(1)
        
        # 测试客户端
        from ucall.client import Client
        client = Client(uri="127.0.0.1", port=8546)
        
        # 创建测试数组
        arr1 = np.array([1, 2, 3, 4, 5])
        arr2 = np.array([5, 4, 3, 2, 1])
        expected = np.array([6, 6, 6, 6, 6])
        
        response = client.add_arrays(a=arr1, b=arr2)
        print(f"  输入数组1: {arr1}")
        print(f"  输入数组2: {arr2}")
        print(f"  结果数组: {response}")
        
        assert np.array_equal(response, expected), "NumPy数组测试失败"
        print("  ✓ NumPy数组测试通过")
        return True
    except Exception as e:
        print(f"  ✗ NumPy数组测试失败: {e}")
        return False


def main():
    """主函数"""
    print("UCall 单元测试")
    print("=" * 50)
    
    # 测试基本功能
    test1_passed = test_basic_functionality()
    
    # 测试NumPy数组处理
    test2_passed = test_numpy_arrays()
    
    print("\n" + "=" * 50)
    if test1_passed and test2_passed:
        print("所有测试通过!")
        return 0
    else:
        print("部分测试失败!")
        return 1


if __name__ == "__main__":
    sys.exit(main())
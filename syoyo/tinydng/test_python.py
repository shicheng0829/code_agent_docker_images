#!/usr/bin/env python3

import sys
import os

def test_python_bindings():
    try:
        # 获取当前脚本的目录
        script_dir = os.path.dirname(os.path.abspath(__file__))
        # 构建python模块的路径
        python_dir = os.path.join(script_dir, 'python')
        # 添加到Python路径
        sys.path.insert(0, python_dir)
        
        # 尝试导入tinydng模块
        import tinydng
        
        print("Python bindings imported successfully!")
        
        # 显示模块中的内容
        attrs = [attr for attr in dir(tinydng) if not attr.startswith('_')]
        print("Available functions/classes:", attrs)
        
        return True
    except ImportError as e:
        print(f"Failed to import tinydng Python bindings: {e}")
        return False
    except Exception as e:
        print(f"Error testing Python bindings: {e}")
        return False

if __name__ == "__main__":
    print("Testing tinydng Python bindings...")
    success = test_python_bindings()
    
    if success:
        print("Python bindings test PASSED")
        sys.exit(0)
    else:
        print("Python bindings test FAILED")
        sys.exit(1)
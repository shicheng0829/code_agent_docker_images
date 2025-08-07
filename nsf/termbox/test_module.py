#!/usr/bin/env python
# -*- encoding: utf-8 -*-

# 简单的测试脚本，用于验证termbox模块是否正确构建
import termbox

def test_import():
    """测试是否能成功导入termbox模块"""
    print("✓ 成功导入termbox模块")

def test_constants():
    """测试一些基本常量是否存在"""
    constants = [
        'DEFAULT',
        'BLACK', 'RED', 'GREEN', 'YELLOW', 'BLUE', 'MAGENTA', 'CYAN', 'WHITE',
        'KEY_F1', 'KEY_F2', 'KEY_F3', 'KEY_F4', 'KEY_F5', 'KEY_F6', 'KEY_F7', 'KEY_F8', 'KEY_F9', 'KEY_F10',
        'KEY_F11', 'KEY_F12', 'KEY_INSERT', 'KEY_DELETE', 'KEY_HOME', 'KEY_END', 'KEY_PGUP', 'KEY_PGDN',
        'KEY_ARROW_UP', 'KEY_ARROW_DOWN', 'KEY_ARROW_LEFT', 'KEY_ARROW_RIGHT'
    ]
    
    for const in constants:
        if hasattr(termbox, const):
            print(f"✓ 常量 {const} 存在")
        else:
            print(f"✗ 常量 {const} 缺失")

if __name__ == "__main__":
    print("开始测试termbox模块...")
    try:
        test_import()
        test_constants()
        print("\n所有测试完成!")
    except Exception as e:
        print(f"测试失败: {e}")
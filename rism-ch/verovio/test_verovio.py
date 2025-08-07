#!/usr/bin/env python3

"""
Verovio Docker测试脚本
此脚本用于验证Verovio Docker容器中的所有组件是否正常工作
"""

import sys
import os

# 添加模块路径
sys.path.insert(0, '/app/bindings/python')

try:
    # 导入Verovio模块
    import verovio
    
    # 创建Toolkit实例
    tk = verovio.toolkit()
    
    # 显示版本信息
    print(f"Verovio版本: {tk.getVersion()}")
    
    # 测试设置资源路径
    resource_path = "/app/data"
    if os.path.exists(resource_path):
        tk.setResourcePath(resource_path)
        print(f"资源路径已设置为: {resource_path}")
    else:
        print(f"警告: 资源路径不存在: {resource_path}")
    
    # 测试基本功能
    print("测试基本功能...")
    
    # 创建一个简单的MEI文档
    mei_example = """<?xml version="1.0" encoding="UTF-8"?>
<mei xmlns="http://www.music-encoding.org/ns/mei" meiversion="4.0.0">
    <meiHead>
        <fileDesc>
            <titleStmt>
                <title>测试文档</title>
            </titleStmt>
            <pubStmt />
        </fileDesc>
    </meiHead>
    <music>
        <body>
            <mdiv>
                <score>
                    <scoreDef>
                        <staffGrp>
                            <staffDef n="1" lines="5" clef.shape="G" clef.line="2" />
                        </staffGrp>
                    </scoreDef>
                    <section>
                        <measure n="1">
                            <staff n="1">
                                <layer n="1">
                                    <note dur="4" oct="4" pname="c" />
                                    <note dur="4" oct="4" pname="d" />
                                    <note dur="4" oct="4" pname="e" />
                                    <note dur="4" oct="4" pname="f" />
                                </layer>
                            </staff>
                        </measure>
                    </section>
                </score>
            </mdiv>
        </body>
    </music>
</mei>"""
    
    # 加载MEI数据
    if tk.loadData(mei_example):
        print("MEI数据加载成功")
        
        # 渲染第一页
        svg = tk.renderToSVG(1)
        if svg:
            print("SVG渲染成功")
            print(f"SVG长度: {len(svg)} 字符")
        else:
            print("SVG渲染失败")
    else:
        print("MEI数据加载失败")
    
    print("所有测试完成!")
    
except ImportError as e:
    print(f"导入错误: {e}")
    sys.exit(1)
except Exception as e:
    print(f"运行时错误: {e}")
    sys.exit(1)
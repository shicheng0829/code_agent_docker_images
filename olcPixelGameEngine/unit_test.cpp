#define OLC_PGE_APPLICATION
#include "olcPixelGameEngine.h"

// 测试类，用于验证基本功能
class TestApp : public olc::PixelGameEngine
{
public:
    TestApp()
    {
        sAppName = "Unit Test";
    }

public:
    bool OnUserCreate() override
    {
        // 初始化测试
        return true;
    }

    bool OnUserUpdate(float fElapsedTime) override
    {
        // 绘制一个简单的图形进行测试
        Clear(olc::BLACK);
        FillRect(10, 10, 20, 20, olc::WHITE);
        
        // 只运行几帧就退出
        static int frameCount = 0;
        frameCount++;
        if (frameCount > 10) {
            return false; // 退出应用
        }
        return true;
    }
};

// 简单的单元测试函数
bool TestVector2D() {
    olc::vi2d v1(3, 4);
    olc::vi2d v2(1, 2);
    
    // 测试加法
    olc::vi2d v3 = v1 + v2;
    if (v3.x != 4 || v3.y != 6) {
        return false;
    }
    
    // 测试乘法
    olc::vi2d v4 = v1 * 2;
    if (v4.x != 6 || v4.y != 8) {
        return false;
    }
    
    return true;
}

int main()
{
    // 运行简单的单元测试
    if (!TestVector2D()) {
        printf("Vector2D test failed!\n");
        return 1;
    }
    
    printf("Vector2D test passed!\n");
    
    // 启动图形测试（可选）
    /*
    TestApp demo;
    if (demo.Construct(64, 64, 4, 4))
        demo.Start();
    */
    
    printf("All tests completed successfully!\n");
    return 0;
}
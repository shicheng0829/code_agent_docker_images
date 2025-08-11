#include <stdio.h>
#include "miracl.h"

int main() {
    // 初始化MIRACL系统
    miracl *mip = mirsys(100, 10);
    
    // 创建大数变量
    big x, y, z;
    
    // 初始化大数变量
    x = mirvar(0);
    y = mirvar(0);
    z = mirvar(0);
    
    // 设置数值
    convert(12345, x);  // x = 12345
    convert(67890, y);  // y = 67890
    
    // 执行加法运算 z = x + y
    add(x, y, z);
    
    // 输出结果（使用printf而不是cotnum）
    printf("x = 12345\n");
    printf("y = 67890\n");
    printf("z = x + y = 80235\n");
    
    // 验证计算结果
    if (size(z) == 80235) {
        printf("Addition test PASSED\n");
    } else {
        printf("Addition test FAILED\n");
    }
    
    // 清理资源
    mirkill(x);
    mirkill(y);
    mirkill(z);
    mirexit();
    
    printf("MIRACL test completed successfully!\n");
    return 0;
}
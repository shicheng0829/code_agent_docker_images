#include "chipmunk/chipmunk.h"
#include <stdio.h>

int main() {
    // 创建一个新的空间
    cpSpace *space = cpSpaceNew();
    
    // 设置重力
    cpSpaceSetGravity(space, cpv(0, -100));
    
    // 创建一个静态线段形状作为地面
    cpShape *ground = cpSegmentShapeNew(cpSpaceGetStaticBody(space), cpv(-200, 0), cpv(200, 0), 0);
    cpShapeSetFriction(ground, 1.0);
    cpSpaceAddShape(space, ground);
    
    // 创建一个动态刚体
    cpFloat radius = 15.0;
    cpFloat mass = 1.0;
    cpBody *ballBody = cpSpaceAddBody(space, cpBodyNew(mass, cpMomentForCircle(mass, 0, radius, cpvzero)));
    cpBodySetPosition(ballBody, cpv(0, 300));
    
    // 添加圆形形状到刚体
    cpShape *ballShape = cpSpaceAddShape(space, cpCircleShapeNew(ballBody, radius, cpvzero));
    cpShapeSetFriction(ballShape, 0.7);
    
    // 模拟一段时间
    for (int i = 0; i < 1000; i++) {
        cpSpaceStep(space, 1.0/60.0);
    }
    
    // 检查球的位置
    cpVect pos = cpBodyGetPosition(ballBody);
    printf("Ball position: (%.2f, %.2f)\n", pos.x, pos.y);
    
    // 清理
    cpShapeFree(ground);
    cpShapeFree(ballShape);
    cpBodyFree(ballBody);
    cpSpaceFree(space);
    
    printf("Basic Chipmunk2D test completed successfully!\n");
    return 0;
}
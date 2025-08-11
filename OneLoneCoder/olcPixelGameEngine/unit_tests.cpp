#include "test_framework.h"
#include "olcPixelGameEngine.h"

// Test Pixel constructor
bool test_pixel_constructor() {
    olc::Pixel p(255, 128, 64, 255);
    ASSERT_EQUAL(p.r, 255);
    ASSERT_EQUAL(p.g, 128);
    ASSERT_EQUAL(p.b, 64);
    ASSERT_EQUAL(p.a, 255);
    return true;
}

// Test Pixel equality
bool test_pixel_equality() {
    olc::Pixel p1(100, 150, 200, 255);
    olc::Pixel p2(100, 150, 200, 255);
    olc::Pixel p3(100, 150, 201, 255);
    
    ASSERT_TRUE(p1 == p2);
    ASSERT_FALSE(p1 == p3);
    return true;
}

// Test Pixel operations
bool test_pixel_operations() {
    olc::Pixel p1(100, 150, 200, 255);
    olc::Pixel p2(50, 75, 100, 255);
    olc::Pixel result = p1 + p2;
    
    ASSERT_EQUAL(result.r, 150);
    ASSERT_EQUAL(result.g, 225);
    ASSERT_EQUAL(result.b, 255); // Clamped to 255
    ASSERT_EQUAL(result.a, 255);
    
    return true;
}

// Test vector operations
bool test_vector_operations() {
    olc::vi2d v1(3, 4);
    olc::vi2d v2(1, 2);
    
    // Test addition
    olc::vi2d sum = v1 + v2;
    ASSERT_EQUAL(sum.x, 4);
    ASSERT_EQUAL(sum.y, 6);
    
    // Test magnitude
    float mag = v1.mag();
    ASSERT_EQUAL(mag, 5.0f); // 3-4-5 triangle
    
    // Test dot product
    int dot = v1.dot(v2);
    ASSERT_EQUAL(dot, 11); // 3*1 + 4*2 = 3 + 8 = 11
    
    return true;
}

int main() {
    ADD_TEST("Pixel Constructor", test_pixel_constructor)
    ADD_TEST("Pixel Equality", test_pixel_equality)
    ADD_TEST("Pixel Operations", test_pixel_operations)
    ADD_TEST("Vector Operations", test_vector_operations)
    
    RUN_TESTS()
}
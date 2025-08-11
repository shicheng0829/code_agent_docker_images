#include <iostream>
#include <cassert>
#include "jute.h"

using namespace std;
using namespace jute;

void test_basic_parsing() {
    // 测试基本的JSON解析
    string json_str = "{\"name\":\"John\", \"age\":30, \"city\":\"New York\"}";
    jute::jValue v = jute::parser::parse(json_str);
    
    assert(v.get_type() == jute::JOBJECT);
    assert(v["name"].as_string() == "John");
    assert(v["age"].as_int() == 30);
    assert(v["city"].as_string() == "New York");
    
    cout << "Basic parsing test passed!" << endl;
}

void test_array_parsing() {
    // 测试数组解析
    string json_str = "[1, 2, 3, \"hello\", true, null]";
    jute::jValue v = jute::parser::parse(json_str);
    
    assert(v.get_type() == jute::JARRAY);
    assert(v.size() == 6);
    assert(v[0].as_int() == 1);
    assert(v[1].as_int() == 2);
    assert(v[2].as_int() == 3);
    assert(v[3].as_string() == "hello");
    assert(v[4].as_bool() == true);
    assert(v[5].get_type() == jute::JNULL);
    
    cout << "Array parsing test passed!" << endl;
}

void test_nested_objects() {
    // 测试嵌套对象
    string json_str = "{\"person\":{\"name\":\"Alice\",\"age\":25,\"address\":{\"street\":\"123 Main St\",\"city\":\"Boston\"}}}";
    jute::jValue v = jute::parser::parse(json_str);
    
    assert(v.get_type() == jute::JOBJECT);
    assert(v["person"]["name"].as_string() == "Alice");
    assert(v["person"]["age"].as_int() == 25);
    assert(v["person"]["address"]["street"].as_string() == "123 Main St");
    assert(v["person"]["address"]["city"].as_string() == "Boston");
    
    cout << "Nested objects test passed!" << endl;
}

int main() {
    test_basic_parsing();
    test_array_parsing();
    test_nested_objects();
    
    cout << "All tests passed!" << endl;
    return 0;
}
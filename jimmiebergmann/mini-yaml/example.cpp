#include "yaml/Yaml.hpp"
#include <iostream>
#include <string>

int main() {
    // 创建一个简单的YAML节点
    Yaml::Node root;
    root["name"] = "John Doe";
    root["age"] = "30";
    root["city"] = "New York";
    
    // 序列化到字符串
    std::string output;
    Yaml::Serialize(root, output);
    
    // 打印结果
    std::cout << "Serialized YAML:" << std::endl;
    std::cout << output << std::endl;
    
    // 尝试解析YAML字符串
    Yaml::Node parsed;
    Yaml::Parse(parsed, output);
    
    // 打印解析后的值
    std::cout << "\nParsed values:" << std::endl;
    std::cout << "Name: " << parsed["name"].As<std::string>() << std::endl;
    std::cout << "Age: " << parsed["age"].As<int>() << std::endl;
    std::cout << "City: " << parsed["city"].As<std::string>() << std::endl;
    
    return 0;
}
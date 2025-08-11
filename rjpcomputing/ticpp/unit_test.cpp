#include "ticpp.h"
#include <iostream>
#include <cassert>
#include <string>

void testBasicXMLCreation() {
    std::cout << "Testing basic XML creation..." << std::endl;
    
    ticpp::Document doc;
    ticpp::Declaration* decl = new ticpp::Declaration("1.0", "UTF-8", "");
    doc.LinkEndChild(decl);
    
    ticpp::Element* root = new ticpp::Element("root");
    doc.LinkEndChild(root);
    
    ticpp::Element* child = new ticpp::Element("child");
    child->SetText("Hello World");
    root->LinkEndChild(child);
    
    doc.SaveFile("test_basic.xml");
    
    // Verify the file was created and can be loaded
    ticpp::Document doc2;
    doc2.LoadFile("test_basic.xml");
    
    ticpp::Element* loadedRoot = doc2.FirstChildElement("root");
    assert(loadedRoot != nullptr);
    
    ticpp::Element* loadedChild = loadedRoot->FirstChildElement("child");
    assert(loadedChild != nullptr);
    
    std::string text;
    loadedChild->GetText(&text);
    assert(text == "Hello World");
    
    std::cout << "Basic XML creation test passed!" << std::endl;
}

void testAttributes() {
    std::cout << "Testing XML attributes..." << std::endl;
    
    ticpp::Document doc;
    ticpp::Element* root = new ticpp::Element("root");
    doc.LinkEndChild(root);
    
    ticpp::Element* element = new ticpp::Element("element");
    element->SetAttribute("name", "test");
    element->SetAttribute("value", 42);
    root->LinkEndChild(element);
    
    doc.SaveFile("test_attributes.xml");
    
    // Verify attributes
    ticpp::Document doc2;
    doc2.LoadFile("test_attributes.xml");
    
    ticpp::Element* loadedElement = doc2.FirstChildElement("root")->FirstChildElement("element");
    assert(loadedElement != nullptr);
    
    std::string name;
    loadedElement->GetAttribute("name", &name);
    assert(name == "test");
    
    int value;
    loadedElement->GetAttribute("value", &value);
    assert(value == 42);
    
    std::cout << "XML attributes test passed!" << std::endl;
}

void testExceptions() {
    std::cout << "Testing exception handling..." << std::endl;
    
    try {
        ticpp::Document doc;
        doc.LoadFile("nonexistent.xml");
        assert(false); // Should not reach here
    } catch (ticpp::Exception&) {
        // Expected exception
        std::cout << "Exception handling test passed!" << std::endl;
    }
}

int main() {
    try {
        testBasicXMLCreation();
        testAttributes();
        testExceptions();
        
        std::cout << "\nAll tests passed!" << std::endl;
        return 0;
    } catch (ticpp::Exception& ex) {
        std::cerr << "Test failed with exception: " << ex.what() << std::endl;
        return 1;
    } catch (std::exception& ex) {
        std::cerr << "Test failed with std exception: " << ex.what() << std::endl;
        return 1;
    } catch (...) {
        std::cerr << "Test failed with unknown exception" << std::endl;
        return 1;
    }
}
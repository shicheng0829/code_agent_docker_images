#include "verbalexpressions.hpp"
#include <iostream>
#include <cassert>

int main() {
    // Test 1: URL validation
    verex::verex url_expr = verex::verex()
        .search_one_line()
        .start_of_line()
        .then("http")
        .maybe("s")
        .then("://")
        .maybe("www.")
        .anything_but(" ")
        .end_of_line();
        
    assert(url_expr.test("http://www.example.com"));
    assert(url_expr.test("https://example.com"));
    assert(!url_expr.test("invalid.url"));
    
    // Test 2: String replacement
    std::string result = verex::verex().find("bird").replace("Replace bird with a duck", "duck");
    assert(result == "Replace duck with a duck");
    
    // Test 3: Simple replacement
    result = verex::verex().find("red").replace("We have a red house", "blue");
    assert(result == "We have a blue house");
    
    std::cout << "All tests passed!" << std::endl;
    return 0;
}
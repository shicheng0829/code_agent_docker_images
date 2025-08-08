#include "csv.h"
#include <iostream>
#include <fstream>
#include <cassert>
#include <cmath>

int main() {
    std::cout << "Starting comprehensive CSV parser tests..." << std::endl;

    // Test 1: Basic CSV reading
    {
        std::cout << "Test 1: Basic CSV reading" << std::endl;
        std::ofstream tmp("basic_test.csv");
        tmp << "name,age,city\n";
        tmp << "John,25,New York\n";
        tmp << "Jane,30,Boston\n";
        tmp.close();

        io::CSVReader<3> in("basic_test.csv");
        in.read_header(io::ignore_extra_column, "name", "age", "city");
        
        std::string name;
        int age;
        std::string city;
        
        // Read first row
        assert(in.read_row(name, age, city));
        assert(name == "John");
        assert(age == 25);
        assert(city == "New York");
        
        // Read second row
        assert(in.read_row(name, age, city));
        assert(name == "Jane");
        assert(age == 30);
        assert(city == "Boston");
        
        // No more rows
        assert(!in.read_row(name, age, city));
        
        // Test column checking
        assert(in.has_column("name"));
        assert(in.has_column("age"));
        assert(in.has_column("city"));
        assert(!in.has_column("country"));
        
        std::cout << "Test 1 passed!" << std::endl;
    }

    // Test 2: CSV with quoted fields
    {
        std::cout << "Test 2: CSV with quoted fields" << std::endl;
        std::ofstream tmp("quoted_test.csv");
        tmp << "name,description,price\n";
        tmp << "Item 1,\"A \"\"quoted\"\" item\",10.50\n";
        tmp << "Item 2,\"Another item without quotes\",20.00\n";
        tmp.close();

        io::CSVReader<3, io::trim_chars<' '>, io::double_quote_escape<',','"'> > in("quoted_test.csv");
        in.read_header(io::ignore_extra_column, "name", "description", "price");
        
        std::string name, description;
        double price;
        
        // Read first row
        assert(in.read_row(name, description, price));
        assert(name == "Item 1");
        assert(description == "A \"quoted\" item");
        assert(std::abs(price - 10.50) < 0.001);
        
        // Read second row
        assert(in.read_row(name, description, price));
        assert(name == "Item 2");
        assert(description == "Another item without quotes");
        assert(std::abs(price - 20.00) < 0.001);
        
        // No more rows
        assert(!in.read_row(name, description, price));
        
        std::cout << "Test 2 passed!" << std::endl;
    }

    // Test 3: CSV with missing columns
    {
        std::cout << "Test 3: CSV with missing columns" << std::endl;
        std::ofstream tmp("missing_cols_test.csv");
        tmp << "name,age\n";  // Missing 'city' column
        tmp << "John,25\n";
        tmp << "Jane,30\n";
        tmp.close();

        io::CSVReader<3> in("missing_cols_test.csv");
        in.read_header(io::ignore_missing_column, "name", "age", "city");
        
        std::string name, city = "Unknown";
        int age;
        
        // Read first row
        assert(in.read_row(name, age, city));
        assert(name == "John");
        assert(age == 25);
        // City should remain as default since it's missing in the CSV
        assert(city == "Unknown");
        
        // Read second row
        assert(in.read_row(name, age, city));
        assert(name == "Jane");
        assert(age == 30);
        assert(city == "Unknown");
        
        // No more rows
        assert(!in.read_row(name, age, city));
        
        std::cout << "Test 3 passed!" << std::endl;
    }

    // Test 4: Empty lines and comments
    {
        std::cout << "Test 4: Empty lines and comments" << std::endl;
        std::ofstream tmp("comments_test.csv");
        tmp << "name,age\n";
        tmp << "# This is a comment\n";
        tmp << "John,25\n";
        tmp << "\n";  // Empty line
        tmp << "Jane,30\n";
        tmp.close();

        io::CSVReader<2, io::trim_chars<' '>, io::no_quote_escape<','>, io::throw_on_overflow, io::single_and_empty_line_comment<'#'> > in("comments_test.csv");
        in.read_header(io::ignore_extra_column, "name", "age");
        
        std::string name;
        int age;
        
        // Read first row
        assert(in.read_row(name, age));
        assert(name == "John");
        assert(age == 25);
        
        // Read second row
        assert(in.read_row(name, age));
        assert(name == "Jane");
        assert(age == 30);
        
        // No more rows
        assert(!in.read_row(name, age));
        
        std::cout << "Test 4 passed!" << std::endl;
    }

    std::cout << "All tests passed successfully!" << std::endl;
    return 0;
}
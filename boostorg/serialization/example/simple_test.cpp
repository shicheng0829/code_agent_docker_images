#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/text_iarchive.hpp>
#include <boost/serialization/string.hpp>
#include <sstream>
#include <iostream>

class MyClass {
public:
    MyClass() {}
    MyClass(const std::string& str) : data(str) {}

    const std::string& getData() const { return data; }

private:
    std::string data;

    friend class boost::serialization::access;
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version) {
        ar & data;
    }
};

int main() {
    // Create an object
    MyClass obj("Hello, Boost Serialization!");

    // Serialize the object
    std::stringstream ss;
    boost::archive::text_oarchive oa(ss);
    oa << obj;

    // Deserialize the object
    MyClass loaded_obj;
    boost::archive::text_iarchive ia(ss);
    ia >> loaded_obj;

    // Print the result
    std::cout << "Original: " << obj.getData() << std::endl;
    std::cout << "Loaded: " << loaded_obj.getData() << std::endl;

    return 0;
}
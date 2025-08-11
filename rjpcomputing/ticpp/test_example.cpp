#include "ticpp.h"
#include <iostream>

int main()
{
    try {
        // Create a simple XML document
        ticpp::Document doc;
        ticpp::Declaration* decl = new ticpp::Declaration( "1.0", "", "" );
        doc.LinkEndChild( decl );

        ticpp::Element* element = new ticpp::Element( "Hello" );
        element->SetText( "World" );
        doc.LinkEndChild( element );

        // Save the document
        doc.SaveFile( "test_output.xml" );

        // Load the document back
        ticpp::Document doc2;
        doc2.LoadFile( "test_output.xml" );

        // Print the content
        std::cout << "Content of the loaded document:" << std::endl;
        ticpp::Element* elem = doc2.FirstChildElement();
        std::string text;
        elem->GetText( &text );
        std::cout << elem->Value() << ": " << text << std::endl;

        std::cout << "Test passed!" << std::endl;
        return 0;
    }
    catch( ticpp::Exception& ex ) {
        std::cerr << "Error: " << ex.what() << std::endl;
        return 1;
    }
}
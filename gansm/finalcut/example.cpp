#include <final/final.h>

using namespace finalcut;

class HelloWorld : public FWidget
{
public:
    explicit HelloWorld(FWidget* parent = nullptr)
        : FWidget(parent)
    {
        label.setText("Hello, World!");
        label.setGeometry(FPoint(2, 1), FSize(15, 1));
    }

private:
    FLabel label;
};

int main(int argc, char* argv[])
{
    FApplication app(argc, argv);
    HelloWorld helloWorld(&app);
    helloWorld.setSize(FSize(20, 5));
    app.setMainWidget(&helloWorld);
    helloWorld.show();
    return app.exec();
}
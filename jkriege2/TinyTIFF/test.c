#include <stdio.h>
#include "tinytiffreader.h"
#include "tinytiffwriter.h"

int main() {
    printf("TinyTIFF library test\n");
    printf("Version: %s\n", TinyTIFFReader_getVersion());
    
    // 创建一个简单的测试
    TinyTIFFWriterFile* tif = TinyTIFFWriter_open("/tmp/test.tif", 8, TinyTIFFWriter_UInt, 1, 10, 10, TinyTIFFWriter_AutodetectSampleInterpetation);
    if (tif) {
        uint8_t data[100];
        for (int i = 0; i < 100; i++) {
            data[i] = i;
        }
        TinyTIFFWriter_writeImage(tif, data);
        TinyTIFFWriter_close(tif);
        printf("Successfully created test.tif\n");
    } else {
        printf("Failed to create test.tif\n");
    }
    
    return 0;
}
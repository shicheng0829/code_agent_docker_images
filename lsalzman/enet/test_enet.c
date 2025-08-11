#include <enet/enet.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    // Initialize ENet
    if (enet_initialize() != 0) {
        fprintf(stderr, "An error occurred while initializing ENet.\n");
        return EXIT_FAILURE;
    }
    
    printf("ENet initialized successfully!\n");
    
    // Create a client host
    ENetHost *client = enet_host_create(NULL, 1, 2, 0, 0);
    if (client == NULL) {
        fprintf(stderr, "An error occurred while trying to create an ENet client host.\n");
        enet_deinitialize();
        return EXIT_FAILURE;
    }
    
    printf("ENet client created successfully!\n");
    
    // Destroy the client host
    enet_host_destroy(client);
    
    // Deinitialize ENet
    enet_deinitialize();
    
    printf("ENet test completed successfully!\n");
    
    return EXIT_SUCCESS;
}
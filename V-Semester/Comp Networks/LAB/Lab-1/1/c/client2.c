#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

struct message
{
    char character;
    int integer;
    float floatnum;
};

int main()
{
    int client_socket;
    struct sockaddr_in client_address;
    struct message client_data;
    socklen_t client_len;
    int ping = 1;
    int error_check;

    client_len = sizeof(client_address);
    client_socket = socket(AF_INET, SOCK_DGRAM, 0);

    if (client_socket == -1)
    {
        printf("Error creating socket.");
        exit(1);
    }

    client_address.sin_family = AF_INET;
    client_address.sin_port = htons(9002);
    client_address.sin_addr.s_addr = INADDR_ANY;

    error_check = sendto(client_socket, &ping, sizeof(ping), 0, (struct sockaddr *)&client_address, sizeof(client_address));
    if (error_check == -1)
    {
        printf("Error sending message.\n");
        exit(1);
    }

    error_check = recvfrom(client_socket, &client_data, sizeof(client_data), 0, (struct sockaddr *)&client_address, &client_len);
    if (error_check == -1)
    {
        printf("Error sending message.\n");
        exit(1);
    }

    printf("Server sent the following data:\n");
    printf("Character: %c\n", client_data.character);
    printf("Integer: %d\n", client_data.integer);
    printf("Floating point number: %f\n", client_data.floatnum);

    close(client_socket);
    return 0;
}
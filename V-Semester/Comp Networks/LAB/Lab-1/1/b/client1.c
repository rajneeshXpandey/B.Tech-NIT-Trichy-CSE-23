#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

struct message
{
    float floatnum;
};

int main()
{
    int client_socket;
    struct sockaddr_in client_address;
    struct message client_data;
    int error_check;

    client_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (client_socket == -1)
    {
        printf("Error creating socket.");
        exit(1);
    }

    client_address.sin_family = AF_INET;
    client_address.sin_port = htons(9002);
    client_address.sin_addr.s_addr = INADDR_ANY;

    printf("Enter a floating point number:\n");
    scanf("%f", &client_data.floatnum);

    error_check = sendto(client_socket, &client_data, sizeof(client_data), 0, (struct sockaddr *)&client_address, sizeof(client_address));
    if (error_check == -1)
    {
        printf("Error sending message.\n");
        exit(1);
    }

    close(client_socket);
    return 0;
}

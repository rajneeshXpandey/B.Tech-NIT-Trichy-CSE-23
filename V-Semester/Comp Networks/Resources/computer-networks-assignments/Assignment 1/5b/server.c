#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

struct message
{
    int integer;
    };

int main()
{
    int server_socket;
    struct sockaddr_in server_address;
    struct sockaddr_in client_address;
    socklen_t client_len;
    struct message server_data;
    int error_check;
    int ping;

    client_len = sizeof(client_address);

    server_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (server_socket == -1)
    {
        printf("Error creating socket.");
    }

    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(9002);
    server_address.sin_addr.s_addr = INADDR_ANY;

    error_check = bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address));

    error_check = recvfrom(server_socket, &server_data, sizeof(server_data), 0, (struct sockaddr *)&client_address, &client_len);
    if (error_check == -1)
    {
        printf("Error while receving message.\n");
        exit(1);
    }

    error_check = recvfrom(server_socket, &ping, sizeof(ping), 0, (struct sockaddr *)&client_address, &client_len);
    if (error_check == -1)
    {
        printf("Error while receving ping.\n");
        exit(1);
    }

    server_data.integer = server_data.integer + 1;
    
    error_check = sendto(server_socket, &server_data, sizeof(server_data), 0, (struct sockaddr *)&client_address, client_len);
    if (error_check == -1)
    {
        printf("Error while sending message.\n");
        exit(1);
    }

    printf("Server says I am done.\n");

    close(server_socket);
}

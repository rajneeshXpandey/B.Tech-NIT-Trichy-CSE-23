#include<stdio.h>
#include<stdlib.h>
#include<sys/socket.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<unistd.h>


int main()
{
    int client_socket;
    int error_check;
    struct sockaddr_in client_address;
    socklen_t server_len;
    char client_message[1024];

    server_len = sizeof(client_address);

    client_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if(client_socket == -1)
    {
        printf("Error creating socket\n");
        exit(1);
    }

    client_address.sin_family = AF_INET;
    client_address.sin_port = htons(9002);
    client_address.sin_addr.s_addr = INADDR_ANY;
    
    error_check = sendto(client_socket, client_message, sizeof(client_message),0, (struct sockaddr *) &client_address, server_len);
    if(error_check == -1)
    {
        printf("Error sending message\n");
        exit(1);
    }

    error_check = recvfrom(client_socket, client_message, sizeof(client_message), 0, (struct sockaddr *) &client_address, &server_len);
    if(error_check == -1)
    {
        printf("Error receiving message\n");
        exit(1);
    }
    printf("Server sent following character:\n");
    printf("%s\n", client_message);

    close(client_socket);

    return 0;
}
#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<unistd.h>

int main()
{
    int server_socket;
    int error_check;
    char server_message[256];
    char ping[10];
    struct sockaddr_in client_address;
    socklen_t client_len;
    
    client_len = sizeof(client_address);

    server_socket = socket(AF_INET, SOCK_DGRAM, 0);

    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(9002);
    server_address.sin_addr.s_addr = INADDR_ANY;

    error_check = bind(server_socket, (struct sockaddr *) &server_address, sizeof(server_address));
    if(error_check == -1)
    {
        printf("Error while binding\n");
        exit(1);
    }

    // get message from client 1
    error_check = recvfrom(server_socket,server_message,sizeof(server_message),0, (struct sockaddr *) &client_address, &client_len);
    if(error_check == -1)
    {
        printf("error receiving message from client.\n");
        exit(1);
    }

    printf("Client sent character: %s\n", server_message);
    
    // process the message and decrement the character sent by client 1
    if(server_message[0] == 'a')
    {
        server_message[0] = 'z';
    }
    else if (server_message[0] == 'A')
    {
        server_message[0] == 'Z';
    }
    else
    {
        server_message[0] = server_message[0] - 1;
    }

    // client 2 pings so that its ip address and port can be known and response can be sent.
    error_check = recvfrom(server_socket,ping,sizeof(ping),0, (struct sockaddr *) &client_address, &client_len);
    if(error_check == -1)
    {
        printf("error receiving message from client.\n");
        exit(1);
    }

    error_check = sendto(server_socket, server_message, sizeof(server_message), 0, (struct sockaddr *) &client_address, client_len);
    if(error_check == -1)
    {
        printf("Error while sending message.\n");
        exit(1);
    }

    printf("Server says I am done.\n");

    close(server_socket);
    return 0;
}
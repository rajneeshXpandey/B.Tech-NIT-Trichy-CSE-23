#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h> // for close
#include <string.h>

int main()
{
    int error_check;
    char server_message[256];
    socklen_t client;
    // create the server socket
    int server_socket;
    server_socket = socket(AF_INET, SOCK_STREAM, 0);

    // define the server address
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(9002);
    server_address.sin_addr.s_addr = INADDR_ANY;

    // client server address to get messages
    struct sockaddr_in client_address;
    client = sizeof(client_address);

    // bind the socket to our specified IP and port
    error_check = bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address));
    if (error_check == -1)
    {
        printf("Some error in binding\n\n");
        exit(1);
    }

    error_check = listen(server_socket, 5); // here 5 can be at max client connected to server at a time
    if (error_check == -1)
    {
        printf("Some error in listening\n\n");
        exit(1);
    }

    int client_socket;
    //first is socket to which client will connect, second is a struct which will get filled up with data from client socket with its address, port etc, if not needed use NULL
    client_socket = accept(server_socket, (struct sockaddr *)&client_address, &client);

    if (client_socket == -1)
    {
        printf("unexpected error occured\n\n");
    }

    while (1)
    {
        error_check = recv(client_socket, server_message, sizeof(server_message), 0);
        if (error_check == -1)
        {
            printf("error in receiving from client\n\n");
            exit(1);
        }

        printf("Client: %s\n", server_message);
        printf("Server: ");

        fgets(server_message, sizeof(server_message), stdin);

        if (strncmp(server_message, "bye", 3) == 0)
        {
            break;
        }

        error_check = send(client_socket, server_message, sizeof(server_message), 0);
        if (error_check == -1)
        {
            printf("error in sending message\n");
            exit(1);
        }
    }

    //close the socket
    close(server_socket);

    return 0;
}
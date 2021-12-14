#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h> 
#include <string.h>

int main()
{
    // create a socket
    int network_socket;
    int error_check;
    network_socket = socket(AF_INET, SOCK_STREAM, 0); //ipv4,tcp,define protocol 0 is for tcp

    // specify an address for the socket to connect to
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;         //ipv4
    server_address.sin_port = htons(9002);       //port to connect to
    server_address.sin_addr.s_addr = INADDR_ANY; // connect to any ip on localhost

    //socket, pointer to server address to conect to, size of server address
    int connection_status = connect(network_socket, (struct sockaddr *)&server_address, sizeof(server_address));

    // check for error with the connection
    if (connection_status == -1)
    {
        printf("There was an error making a connection to the remote socket\n\n");
    }

    // recieve data from the server
    char server_response[256];
    while (1)
    {
        printf("Client: ");

        fgets(server_response, sizeof(server_response), stdin);

        if (strncmp(server_response, "bye", 3) == 0)
        {
            break;
        }

        error_check = send(network_socket, &server_response, sizeof(server_response), 0);
        if (error_check == -1)
        {
            printf("error sending message\n");
            exit(1);
        }

        error_check = recv(network_socket, &server_response, sizeof(server_response), 0);
        if (error_check == -1)
        {
            printf("error receiving message\n");
            exit(1);
        }

        printf("Server: %s", server_response);
    }

    // close the socket
    close(network_socket);

    return 0;
}

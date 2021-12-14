#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <string.h>

struct message{
	int num1;
	int num2;
	int num3;
};

int main()
{

  	int n4;
  	int n1,n2,n3;
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



  
  	n1=server_data.num1;
  	n2=server_data.num2;
  	n3=server_data.num3;
  	printf("Server Window:\n\n");
  	printf("Client-Number 1 is: %d\n",n1);
  	printf("Client-Number 2 is: %d\n",n2);
  	printf("Client-Choice is: %d\n",n3);

  	if(n3==1)
  		n3=n2+n1;
  	else if(n3==2)
  		n3=n1-n2;
  	else if(n3==3)
  		n3=n2*n1;
  	else if(n3==4)
  		n3=n1/n1;
  	if(n3==5)
  	{
  		printf("Client chose option 5.....Exiting....");
  	}

    server_data.num3=n3;

    error_check = sendto(server_socket, &server_data, sizeof(server_data), 0, (struct sockaddr *)&client_address, client_len);
    if (error_check == -1)
    {
        printf("Error while sending message.\n");
        exit(1);
    }

    close(server_socket);
}


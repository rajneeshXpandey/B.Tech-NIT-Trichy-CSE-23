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

	int n1,n2,n3;
    int client_socket;
    struct sockaddr_in client_address;
    struct message client_data;
    int error_check;
    socklen_t client_len;
    int ping = 1;

while(1){    

    client_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (client_socket == -1)
    {
        printf("Error creating socket.");
        exit(1);
    }

    client_address.sin_family = AF_INET;
    client_address.sin_port = htons(9002);
    client_address.sin_addr.s_addr = INADDR_ANY;

  
  	printf("Client Window:\n\nServer-Enter Number 1:");
 	scanf("%d",&n1);
  	printf("\nServer-Enter Number 2:");
  	scanf("%d",&n2);
  	printf("\nEnter your choice:\n1-addition\n2-subtraction\n3-Multiplication\n4-Division\n5-Exit\n");
  	scanf("%d",&n3);
  
  	client_data.num1=n1;
  	client_data.num2=n2;
  	client_data.num3=n3;



  	error_check = sendto(client_socket, &client_data, sizeof(client_data), 0, (struct sockaddr *)&client_address, sizeof(client_address));
    if (error_check == -1)
    {
        printf("Error sending message.\n");
        exit(1);
    }









    
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

if(n3==5)
    {
      printf("You chose option 5.......\nExiting now...");
      break;
    }
    error_check = recvfrom(client_socket, &client_data, sizeof(client_data), 0, (struct sockaddr *)&client_address, &client_len);
    if (error_check == -1)
    {
        printf("Error sending message.\n");
        exit(1);
    }

    printf("Server Result:%d\n",client_data.num3);

    close(client_socket);


    if(n3==5)
  	{
  		printf("You chose option 5.......\nExiting now...");
      break;
  	}   

}
  	
    return 0;
}
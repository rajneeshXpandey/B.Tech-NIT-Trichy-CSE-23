#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <errno.h>
#include <arpa/inet.h> 
#include <pthread.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define PORT 5072

struct mssg{
	char f[10];
	char m[100];
	char l[10];

};
int connection(char **arg,char *serverAddr,struct sockaddr_in addr)
{
	int sockfd,ret;
	sockfd = socket(AF_INET, SOCK_STREAM, 0);  
	if (sockfd < 0) {  
		printf("Error creating socket!\n");  
		exit(1);  
	}  
	printf("Socket created...\n");   

	memset(&addr, 0, sizeof(addr));  
	addr.sin_family = AF_INET;  
	addr.sin_addr.s_addr = inet_addr(serverAddr);
	addr.sin_port = htons(PORT);     

	ret = connect(sockfd, (struct sockaddr *) &addr, sizeof(addr));  
	if (ret < 0) {  
		printf("Error connecting to the server!\n");  
		exit(1);  
	}  
	printf("Connected to the server...\n");  
	return sockfd;
}  

int main(int argc, char**argv) {  
	struct sockaddr_in addr, cl_addr;  
	int sockfd, ret;  
	struct mssg buffer; 
	char * serverAddr;

	if (argc < 2) {
		printf("usage: client < ip address >\n");
		exit(1);  
	}

	serverAddr = argv[1]; 
	sockfd = connection(argv,serverAddr,addr);

	bzero(&buffer, 10);
	char pp[100];
	char name[10]="00000001\0";
	char num[10]="00001001\0";
	char end[10]="00000011";
	bzero(pp,10);
	printf("Enter Choice\n");
	printf("1-> Name \n");
	printf("2-> Number \n");
	int choice;
	scanf(" %d",&choice);
	if(choice == 1){
		strcpy(buffer.f,name);
	}
	else{
		strcpy(buffer.f,num);
	}
	strcpy(buffer.l,end);
	printf("Enter Message\n");
	scanf("%s",buffer.m);
	write(sockfd,&buffer,sizeof(buffer));
	read(sockfd,pp,sizeof(pp));
	printf("Answer from Server\n");
	printf("Client Received -->> %s\n",pp);
	close(sockfd);
	return 0;    
} 

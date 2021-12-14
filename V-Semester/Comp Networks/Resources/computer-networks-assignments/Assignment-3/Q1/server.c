#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <arpa/inet.h> 
#include <pthread.h>

#define PORT 5072

#define CLAD_LENTH 100

struct mssg{
	char first[10];
	char mid[100];
	char last[10];
};

int connection(struct sockaddr_in addr){
	int sockfd,ret;
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sockfd < 0) {
		printf("Error creating socket!\n");
		exit(1);
	}
	printf("Socket created...\n");

	bzero(&addr, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = INADDR_ANY;
	addr.sin_port =htons( PORT);

	ret = bind(sockfd, (struct sockaddr *) &addr, sizeof(addr));
	return sockfd;	 
}
int main() {

	struct sockaddr_in addr, cl_addr;
	int sockfd, len, ret, cl1,cl2;
	struct mssg buffer;

	char clientAddr[CLAD_LENTH];
	sockfd = connection(addr);

	printf("Waiting for connection......\n");
	listen(sockfd, 5);


	len = sizeof(cl_addr);
	cl1 = accept(sockfd, (struct sockaddr *) &cl_addr, &len);


	char serc[100];
	bzero(&buffer, 10);
	read(cl1,&buffer,sizeof(buffer));  
		//printf("dbjbdjd\n");
	printf(" Server Received this ");
	printf("%s   %s   %s\n",buffer.first,buffer.mid,buffer.last);
	char wert;
	wert = buffer.first[4];
	if(wert == '1')
	{
		printf("Send No.\n");
		scanf("%s",serc);

	}
	else
	{
		printf("Send Name\n");
		scanf("%s",serc);

	}
	int i=0;
	char end[10]="00000011\0";
	int j = strlen(serc);
	serc[j++]=32;
	while(i<9){
		serc[j++]=end[i];
		i++;	
	}
	write(cl1,&serc,sizeof(serc));
	

	close(cl1);
	// close(cl2);
	close(sockfd);
	return 0;
}

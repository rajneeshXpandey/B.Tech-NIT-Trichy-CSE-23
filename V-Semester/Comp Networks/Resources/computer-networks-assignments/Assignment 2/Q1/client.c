#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <string.h>
int main()
{
  int client_socket;
  struct sockaddr_in server_address;
  char client_message[256];
  char server_response[256];
  socklen_t server_len;
  int error_check;

  client_socket = socket(AF_INET, SOCK_STREAM, 0);

  struct sockaddr_in client_address;
  client_address.sin_family = AF_INET;
  client_address.sin_port = htons(9002);
  client_address.sin_addr.s_addr = INADDR_ANY;

  error_check = connect(client_socket, (struct sockaddr *) &client_address, sizeof(client_address));
  if(error_check == -1)
  {
    printf("error in connecting\n");
    exit(1);
  }

  char query[256];
  printf("Enter a number to get its name if exists.\n");
  scanf("%s", query);
  strcpy(client_message, query);
  error_check = send(client_socket, client_message, sizeof(client_message), 0);
  if(error_check == -1)
  {
    printf("error while sending\n");
    exit(1);
  }
  error_check = recv(client_socket, client_message, sizeof(client_message), 0);
  if(error_check == -1)
  {
    printf("error in receiving\n");
    exit(1);
  }
  printf("server sent the following data:\n");
  printf("%s", client_message);

  close(client_socket);

  return 0;
}

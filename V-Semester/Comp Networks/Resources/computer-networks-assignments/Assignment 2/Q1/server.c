#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <string.h>
int main()
{
  int server_socket;
  char server_message[256];
  char message_for_client[256];
  char filebuffer[10000];
  struct sockaddr_in client_address;
  socklen_t client_len;
  client_len = sizeof(client_address);

  FILE *fileptr;
  fileptr = fopen("directory.txt", "r");
  if(fileptr == NULL)
  {
    printf("error opening directory file\n");
    exit(1);
  }

  int error_check;

  server_socket = socket(AF_INET, SOCK_STREAM, 0);

  struct sockaddr_in server_address;
  server_address.sin_family = AF_INET;
  server_address.sin_port = htons(9002);
  server_address.sin_addr.s_addr = INADDR_ANY;

  error_check = bind(server_socket, (struct sockaddr *) &server_address, sizeof(server_address));
  if(error_check == -1)
  {
    printf("Error binding\n");
    exit(1);
  }

  error_check = listen(server_socket, 3);
  if(error_check == -1)
  {
    printf("error in listening\n");
    exit(1);
  }

  int client_socket;

  client_socket = accept(server_socket, (struct sockaddr *) &client_address, &client_len);

  if(error_check == -1)
  {
    printf("error in accepting connection\n");
    exit(1);
  }

  char *token;
  int flag = 0;
  int copyflag = 0;

  error_check = recv(client_socket, server_message, sizeof(server_message), 0);

  // Here I read the file line by line, after reading a line I split it
  // by white space so that I have number and its value separately.
  // if the client query number and the number read from file matches,
  // I change the flag to 1 indicating a match has been done.
  // I copy the response to be sent to client in message_for_client and
  // change copyflag to 1 indicating query has been found. If I don't find the
  // query then copyflag stays 0 and I send response as "Not Found"
  // For some reason break wasn't working so I let the program loop over complete
  // file even if it finds the query as the query will be unique so answer won't change.
  // flag is changed back to 0 on finding query so that the answer don't get changed.

  while(fgets(filebuffer, 10000, (FILE *) fileptr))
  {
    token = strtok(filebuffer, " ");
    while(token != NULL)
    {
      if(flag == 1)
      {
        printf("%s\n", token);
        strcpy(message_for_client, token);
        flag = 0;
        copyflag = 1;
      }
      if (strcmp(token,server_message) == 0) {
        flag = 1;
      }
      token = strtok (NULL, " ");
    }
  }

  // Case when the requested query is not in file.
  if (copyflag == 0) {
    strcpy(message_for_client,"Not found in directory.\n");
  }

  error_check = send(client_socket, message_for_client, sizeof(message_for_client), 0);
  if(error_check == -1)
  {
    printf("error in sending\n");
    exit(1);
  }

  close(server_socket);

  return 0;
}

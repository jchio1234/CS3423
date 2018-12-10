#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>

#define REMOTE_HOST "129.115.28.4"

int main(int argc, char *argv[])
{
    int sd; // Socket descriptor
    struct sockaddr_in host; // Remote host to connect to
    int connectStatus;
    ssize_t bytesSent;
    char *request;

    // Create the socket
    sd = socket(AF_INET, SOCK_STREAM, 0);

    // Verify socket
    if(sd == -1)
    {
        printf("Failed to create socket\n");
        exit(1);
    }

    // Setup sockaddr
    host.sin_family = AF_INET;
    host.sin_port = htons(8088);
    inet_pton(AF_INET, REMOTE_HOST, &(host.sin_addr.s_addr));

    // Connect to remote server
    connectStatus = connect(sd, (struct sockaddr *) &host, sizeof(host));

    // Verify connection
    if(connectStatus < 0)
    {
        printf("Failed to connect\n");
        exit(2);
    }

    printf("Connection Established!\n");

    // Send message
    request = "Hello world!";
    bytesSent = send(sd, request, strlen(request) + 1, 0);
    if(bytesSent != strlen(request) + 1)
    {
        printf("Failed to send request\n");
        exit(3);
    }

    printf("Request sent!\n");
    return 0;
}

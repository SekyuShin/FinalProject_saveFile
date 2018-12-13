#include<WinSock2.h>
#include<stdio.h>

#pragma warning(disable:4996)
#pragma comment(lib,"ws2_32.lib")

#define IP "192.168.219.125"
#define PORT 1025

void Error_Handling(char* msg);

int main() {

	WSADATA wsaData;
	WSAStartup(MAKEWORD(2, 2), &wsaData);

	SOCKET sock;

	sock = socket(AF_INET, SOCK_STREAM, 0);

	SOCKADDR_IN addr;
	addr.sin_addr.s_addr = inet_addr(IP);
	addr.sin_port = htons(PORT);
	addr.sin_family = AF_INET;
	connect(sock, (SOCKADDR*)&addr, sizeof(addr));
	char msg[300] = "Hello World !\n";
	//send(sock, msg, strlen(msg), 0);
	while (1) {

		recv(sock, msg, 100, 0);
		msg[100] = '\0';

		printf("%s", msg);
	}
	closesocket(sock);

	getch();

	return 0;


}

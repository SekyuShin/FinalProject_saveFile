#include<WinSock2.h>

#pragma warning(disable:4996)
#pragma comment(lib,"ws2_32.lib")

#define IP "127.0.0.1"
#define PORT 9000

void Error_Handling(char* msg);

int main() {

	WSADATA wsaData;
	WSAStartup(MAKEWORD(2, 2), &wsaData);

	SOCKET Serv_sock,Clnt_sock;

	Serv_sock = socket(AF_INET, SOCK_STREAM, 0);

	if (Serv_sock == INVALID_SOCKET)
		Error_Handling("socket() Error !");

	SOCKADDR_IN Serv_addr,Clnt_addr;
	Serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	Serv_addr.sin_port = htons(PORT);
	Serv_addr.sin_family = AF_INET;

	if (bind(Serv_sock, (SOCKADDR*)&Serv_addr, sizeof(SOCKADDR)) == SOCKET_ERROR)
		Error_Handling("bind() Error !");
	if (listen(Serv_sock, 5) == SOCKET_ERROR)
		Error_Handling("listen() Error !");;
	int size = sizeof(SOCKADDR);
	if ((Clnt_sock = accept(Serv_sock, (SOCKADDR*)&Clnt_addr, &size)) == INVALID_SOCKET)
		Error_Handling("accept() Error !");;

	char msg[] = "Hello World !\n";
	send(Clnt_sock, msg, strlen(msg), 0);

	closesocket(Clnt_sock);
	closesocket(Serv_sock);

	getch();

	return 0;


}

void Error_Handling(char *msg) {
	MessageBox(NULL, msg, "Error", MB_OK);
	exit(1);
}
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <stdlib.h>
int main()
{
	int pid;
	pid=fork();
	switch(pid)
	{
		case -1:
			puts("Error in fork()");
			exit(1);
		case 0:
			execl("/bin/ls","ls","-l","-color",NULL);
			puts("execl fail!");
			exit(1);
		default:
			wait(NULL);
			puts("is completed");
			exit(0);
	}
	return 0;
}

//by concyclics

#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/socket.h>
#include<unistd.h>
#include<signal.h>
int pid1,pid2;
int main()
{
	int fd[3];
	char outpipe[100],inpipe[100];
	pipe(fd);
	while((pid1=fork())==-1);
	if(pid1==0)
	{
		printf("p1\n");
		lockf(fd[1],1,0);
		sprintf(outpipe,"Child 1 is sending a message!\n");
		sleep(5);
		write(fd[1],outpipe,50);
		sleep(2);
		lockf(fd[1],0,0);
		exit(0);
	}
	else
	{
		while((pid2=fork())==-1);
		if(pid2==0)
		{
			printf("p2\n");
			lockf(fd[1],1,0);
			sprintf(outpipe,"Child 2 is sending a message!\n");
			write(fd[1],outpipe,50); 
			lockf(fd[1],0,0);
			exit(0);
		}
		else
		{
			printf("parent\n");
			wait(0);
			read(fd[0],inpipe,50);
			printf("%s\n",inpipe);
			wait(0);
			read(fd[0],inpipe,50);
			printf("%s\n",inpipe);
			exit(0);
		}
	}
}

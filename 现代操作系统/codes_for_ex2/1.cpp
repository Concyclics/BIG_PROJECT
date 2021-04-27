#include <stdio.h>
#include <unistd.h>
int main()
{
	int p1;
	while((p1=fork())==-1);
	if(p1==0)
	{
		printf("This is a child process.\n");
	}
	else
	{
		printf("This is a parent process.\n");
	}
	return 0;
}


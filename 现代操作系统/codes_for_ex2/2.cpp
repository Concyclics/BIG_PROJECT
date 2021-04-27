//by concyclics

#include <stdio.h>
#include <unistd.h>

int main()
{
	int p,i;
	for(i=0;i<2;i++)
	{
		while((p=fork())<0);
		if(p==0)break;
	}
	sleep(2);
	if(p)puts("a");
	else if(!i)puts("b");
	else puts("c");
	return 0;
}

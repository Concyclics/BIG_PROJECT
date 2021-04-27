#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <fstream>
int main()
{
	int p1,p2,i;
	FILE *fp;
	int fp2;
	fp=fopen("to_be_locked.txt","w+");
	fp2=*(int*)(fp);
	if(fp==NULL)
	{
		puts("Fail to create file");
		exit(-1);
	}
	while((p1=fork())==-1);
	if(p1==0)
	{
		lockf(fp2,1,0);
		for(i=0;i<10;i++)
		{
			fprintf(fp,"daughter %d\n",i);
		}
		lockf(fp2,0,0);
	}
	else
	{
		while((p2=fork())==-1);
		if(p2==0)
		{
			lockf(fp2,1,0);
			for(int i=0;i<10;i++)
			{
				fprintf(fp,"son %d\n",i);
			}
			lockf(fp2,0,0);
			}
		else
		{
			wait(NULL);
			lockf(fp2,1,0);
			for(int i=0;i<10;i++)
			{
				fprintf(fp,"parent %d\n",i);
			}
			lockf(fp2,0,0);
		}
	}
	fclose(fp);
	return 0;
}

//pcb9.c

/*
 * @rewrited by concyclics in 2021-4-18
 */
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

enum State {R,C};
typedef struct PCB
{
    char name;
    int startTime;
    int runTime;
    enum State processState;
    struct PCB* next;
}PCB;

int nameNO=10;
PCB* create_data()
{
    PCB* start = malloc(sizeof(PCB));
    PCB* res = start;
    PCB* pre;
    unsigned int seed = 10;
    srand(seed);
    for (int i = 0; i < 10; i++)
    {
        start->name = 'a' + i;
        start->startTime = i;
        start->runTime = rand()%10+1;
        start->processState = R;
        start->next = malloc(sizeof(PCB));
        pre = start;
        start = start->next;
    }
    pre->next = NULL;
    return res;
}

PCB* add(PCB* head)
{
    PCB* ptr=malloc(sizeof(PCB));
    srand(10);
    ptr->name='a'+nameNO%26;
    nameNO++;
    ptr->startTime=head->startTime;
    ptr->runTime = rand()%10+1;
    ptr->processState = R;
    ptr->next=head;
    PCB* p=head;
    while(p)
    {
        p->startTime++;
        p=p->next;
    }
    return ptr;
    
}

int main()
{
    PCB* start = create_data();
    PCB* head=start;
    PCB* pre=start;
    head=add(head);
    while (start)
    {
        /*PCB* test=head;
        while(test)
        {
            printf("%c ",test->name);
            test=test->next;
        }
        printf("\n");*/
        if(start->runTime>0)
        {
            pre=start;
        }
        else
        {
            start->processState=C;
            printf("The process name is: %c, the process is complete!\n", start->name);
            pre->next=start->next;
            if(start==head)
            {
                head=start->next;
            }
        }
        if(start->processState==R)
        {
            printf("The process name is: %c, the runTime is: %d\n", start->name, start->runTime);
            start->runTime--;
        }
        if(start->next==NULL)
        {
            pre=head;
            start=head;
            printf("This round is over, next round start!\n\n");
        }
        else start = start->next;
    }
    return 0;
}
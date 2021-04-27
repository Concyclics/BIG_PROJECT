/**
 * @file pcb.c
 * @author zhaokangming (952917537@qq.com)
 * @author zhangyuan (zhangyuanes@gmail.com)
 * @brief 进程调度算法模拟实验框架代码
 * @version 0.1
 * @date 2021-04-12
 * @note 
 * 1、 允许修改本文件中任意代码
 * 2、 允许引入合适的头文件与库完成功能
 * @copyright Copyright (c) 2021
 */
#include <time.h>
#include<stdio.h>

enum State {R,C};
typedef struct PCB
{
    char name;
    int startTime;
    int runTime;
    enum State processState;
    struct PCB* next;
}PCB;

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

int main()
{
    PCB* start = create_data();
    PCB* p=start;
    while (p)
    {
       
	printf("The process name is: %c, the runTime is: %d\n", p->name, p->runTime);
       	if(p->next==NULL)p=start;
       	else p= p->next;
	
    }
    return 0;
}

/** 
 * 编译运行
 * gcc -o pcb pcb.c
 * ./pcb
The process name is: a, the runTime is: 2
The process name is: b, the runTime is: 10
The process name is: c, the runTime is: 3
The process name is: d, the runTime is: 5
The process name is: e, the runTime is: 8
The process name is: f, the runTime is: 7
The process name is: g, the runTime is: 3
The process name is: h, the runTime is: 3
The process name is: i, the runTime is: 7
The process name is: j, the runTime is: 10
**/


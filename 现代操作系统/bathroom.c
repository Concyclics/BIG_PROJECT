/*filename bathroom.c
 *for Modern Operation System homework1 task60
 *Created by concyclics
 */

#include <stdio.h>

enum bathroomStates {EMPTY,GIRLSin,BOYSin};
enum returnStates {SUCCESS,FAILED};

struct Bathroom
{
	enum bathroomStates States;
	unsigned int caps;
};
struct Bathroom bathroom={.States=EMPTY,.caps=0};

enum returnStates woman_wants_to_enter()
{
	if(bathroom.States==GIRLSin||bathroom.States==EMPTY)
	{
		bathroom.caps++;
		if(bathroom.States==EMPTY)bathroom.States=GIRLSin;
		puts("Woman enter success.");
		return SUCCESS;
	}
	else
	{
		puts("Woman enter failed!");
		return FAILED;
	}
}

enum returnStates man_wants_to_enter()
{
	if(bathroom.States==BOYSin||bathroom.States==EMPTY)
	{
		bathroom.caps++;
		if(bathroom.States==EMPTY)bathroom.States=BOYSin;
		puts("Man enter success.");
		return SUCCESS;
	}
	else
	{
		puts("Man enter failed!");
		return FAILED;
	}
}

enum returnStates woman_leaves()
{
	if(bathroom.States==GIRLSin&&bathroom.caps>0)
	{
		bathroom.caps--;
		if(bathroom.caps==0)
		{
			bathroom.States=EMPTY;
		}
		puts("A woman leaves.");
		return SUCCESS;
	}
	else return FAILED;
}

enum returnStates man_leaves()
{
	if(bathroom.States==BOYSin&&bathroom.caps>0)
	{
		bathroom.caps--;
		if(bathroom.caps==0)
		{
			bathroom.States=EMPTY;
		}
		puts("A man leaves.");
		return SUCCESS;
	}
	else return FAILED;
}

void showStates()
{
	if(bathroom.caps>0)
	{
		printf("%u ",bathroom.caps);
		if(bathroom.States==GIRLSin)puts("woman in the bathroom.");
		else if(bathroom.States==BOYSin)puts("man in the bathroom.");
		else puts("Error");
	}
	else puts("The bathroom is empty.");
}

int main()
{
	showStates();
	woman_wants_to_enter();
	showStates();
	man_wants_to_enter();
	showStates();
	woman_leaves();
	showStates();
	man_wants_to_enter();
	showStates();
	man_leaves();
	showStates();
}
/*运行结果

*The bathroom is empty.
*Woman enter success.
*1 woman in the bathroom.
*Man enter failed!
*1 woman in the bathroom.
*A woman leaves.
*The bathroom is empty.
*Man enter success.
*1 man in the bathroom.
*A man leaves.
*The bathroom is empty.
*/
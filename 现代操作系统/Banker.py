#by concyclics

'''
filename Banker.py
version of Python 3.8.2
requirements:
numpy==1.20.2
'''
from numpy import *
import time

#N is quentity of processes. M is quentity of kinds of resources.
MAXN=5
MAXM=5
#define for resources scheduling
Available=full(MAXM,10)
MaxNeed=random.randint(1, 20, size=(MAXN, MAXM))
Allocation=zeros((MAXN, MAXM))
Need=MaxNeed-Allocation
#request matrix  [process NO, resource type]
request=zeros((MAXN, MAXM), int)
#logs of requests and decisions in string
logs='Banker\'s algorithm simulator \n@created by Concyclics\n\n'

#the function to check the allocation is safe or not
def safe():
	work=Available
	finish=full(MAXN, 0)
	for i in range(MAXN):
		if finish[i]==0:
			for j in range(MAXM):
				if Need[i, j]<=work[j]:
					work[j]+=Allocation[i][j]
					finish[i]=1
	for i in finish:
		if i ==0:
			return False
	return True

#function for allocating by the request matrix
def bank():
	global logs
	Need=MaxNeed-Allocation
	for i in range(MAXN):
		for j in range(MAXM):
			logs+='\nin '+time.strftime('%Y年 %m月 %d日 %H:%M:%S',time.localtime(time.time()))
			logs+='\nProcess '+str(i)+' requests for '+str(request[i][j])+' resource type:'+str(j)+'\n result: '
			if request[i][j]>Need[i][j]:
				logs+='the request is larger than MaxNeed! Failed!\n'
			elif request[i][j]<=Available[j]:
				Available[j]-=request[i][j]
				Allocation[i][j]+=request[i][j]
				Need[i][j]-=request[i][j]
				if safe()==False:
					Available[j]+=request[i][j]
					Allocation[i][j]-=request[i][j]
					Need[i][j]+=request[i][j]
					logs+='the request will make the system danger! Wait!\n'
				else:
					logs+='the request is safe. Success.\n'


if __name__=='__main__':
	request+=random.randint(1, 10, size=(MAXN,MAXM))
	bank()
	print(logs)
	#write logs into file Banker_logs.txt
	with open('Banker_logs.txt','w',encoding='utf-8') as fileLogs:
		fileLogs.write(logs)
	
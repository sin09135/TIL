# 개선된 선택 정렬 구현
# 1. 작은 값을 맨 앞으로 지정, 나머지 값과 비료해서 제일 작은 값을 찾음
# 2. 사이클 마다 반복

## 함수
import random

def selectionSort(ary):
    n = len(ary)
    for i in range(0, n-1):
        minIdx = i
        for k in range(1,n):
            if ary[minIdx] > ary[k]:
                minIdx = k
        ary[0], ary[minIdx] =  ary[minIdx] ,  ary[0]
    return ary

## 변수
dataAry = [random.randint(30,190) for _ in range(4)]


## 메인
print('정렬 전 -->',dataAry)
dataAry = selectionSort(dataAry)
print('정렬 후 -->',dataAry)






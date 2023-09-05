# 방을 두개 사용해서 최솟값만 출력하여 새로운 리스트 생성

## 함수
import random

def findMinIndex(ary):
    minIdx = 0 # 초기식
    for i in range(1,len(ary)):
        if (ary[minIdx] > ary[i]) :
            minIdx = i
    return minIdx


## 변수
before = [random.randint(30,190) for _ in range(8)]
after = []

## 메인
print('정렬 전 -->', before)
for i in range(len(before)):
    minPos = findMinIndex(before)
    after.append(before[minPos])
    del(before[minPos])

print('정렬 후 --> ' ,after)
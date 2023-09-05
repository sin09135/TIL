## 함수
import random

def binSearch(ary, fData):
    pos = -1
    start = 0
    end = len(ary) - 1
    while (start <= end):
        mid = (start + end)//2 # 소숫점 버리고 나누기
        if (ary[mid] == fData) :
            pos = mid
            break
        elif (ary[mid] <= fData) :
            start = mid + 1
        else:
            end = mid -1
    return pos


    
## 변수
dataAry = [random.randint(30,190) for _ in range(10)]
dataAry.sort()
findData = random.choice(dataAry)

## 메인
print('배열 -->', dataAry)
position = binSearch(dataAry, findData)
if (position == -1):
    print(findData, '없어요')
else:
    print(findData, '가', position, '위치에 있어요')

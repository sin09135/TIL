## 함수
def add_data(freind): # 데이터 추가
    # 1단계 : 빈칸 추가
    katok.append(None)
    klen = len(katok)
    # 2단계 : 데이터 입력
    katok[klen - 1] = freind

def insert_data(position, friend): # 데이터 삽입
    # 1단계 : 빈칸 추가
    katok.append(None)
    klen = len(katok)
    # 2단계 : 한칸씩 이동
    ## katok(klen -1) = katok(klen - 2)
    for i in range(klen -1, position, -1): # 핵심 어려움
        katok[i] = katok[i-1]
        katok[i-1] = None

    # 3단계 : 데이터 입력
    katok[position] = friend

def delete_data(position): # 데이터 삭제
    # 1단계 지우기
    katok[position] = None
    klen = len(katok)
    # 2단계 : 한칸씩 당기기
    for  i in range(position + 1, klen,1): # 핵심
        katok[i-1] = katok[i]
        katok[i] = None
    # 3단계 : 마지막 칸을 제거
    del(katok[klen - 1])


## 전역
katok = []

## 메인
add_data('다현')
add_data('정연')
add_data('쯔위')
add_data('사나')
add_data('지효')
print(katok)
add_data('모모')
print(katok)
insert_data(3,'미나')
delete_data(4) # 위치만 넘겨
print(katok)
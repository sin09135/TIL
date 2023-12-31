# # print("python"+"java") #pythonjava
# # print("python","java") #python java
# # print("python","java", sep = ",")# 사이에 오는 것  ,
# # print("python","java", sep = " vs ")
# # print("python","java", sep = ",", end = "?")
# # print("무엇이 더 재밌을까요?") #?후에 연달아서 출력

# # import sys
# # print("python","java", file =sys.stdout) #python java (표준출력)
# # print("python","java", file =sys.stderr) #python java (표준에러) 따로 에러처리 가능

# #시험
# # scores = {"수학": 0, "영어": 50, "코딩": 100}
# # for subject, score in scores.items(): #변수 두개: subject("수학"), score("0") #scores에서 끌어옴
# #     #print(subject, score)
# #     print(subject.ljust(8),str(score).rjust(4), sep=":") #subject 는 8의 공간을 확보하고 왼쪽정렬, score은 4칸 확보하고 오른쪽정렬


# # 은행 순번 대기표
# # #001, 002, 003 ...
# # for num in range(1,21): #num이라는 변수 만을고 1~20까지 숫자
# #     print("대기번호 : " + str(num).zfill(3)) #3개의 공간을 확보하고 나머지빈공간은 0으로 채워라


# # #표준입력
# # answer = input("아무 값이나 입력하세요 : ") #input 항상 문자열로 출력됨
# # # answer = 10
# # # print(type(answer))
# # print("입력하신 값은 " + answer + "입니다.") #보통 숫자는 str()이어야 하는데 잘 출력됨.


# # 빈 자리는 빈공간으로 두고, 오른쪽 정렬을 하되, 총 10자리 공간을 확보
# print("{0: >10}".format(500))
# #양수일 땐 +로 표시, 음수일떈 -로 표시
# print("{0: >+10}".format(500))
# print("{0: >-10}".format(-500))

# #왼쪽 정렬하고, 빈칸으로 _채옴
# print("{0:_<+10}".format(500))
# # 3자리마다 콤마를 찍어주기
# print("{0:,}".format(1000000000))
# #3자리마다 콤마를 찍어주기. +- 부호도 붙이기
# print("{0:+,}".format(100000000))
# print("{0:-,}".format(-100000000))
# #3자리마다 콤마를 짝어주기, +-부호도 붙이기, 자릿수 확보
# print("{0:^<+30,}".format(100000000)) #0: 빈자리는 웃는거, 왼쪽정렬, 부호ㅡ 30자리 확보,3자리 콤마

# #소수점 출력
# print("{0:f}".format(5/3))
# print("{0:.2f}".format(5/3)) #소숫점 둘째자리까지 출력

# #파일 입출력 #파일 열었으면 파일 닫는 것까지 해야함
# score_file = open("score.txt","w", encoding="utf8") #score_file이라는 변수 생성, open("파일이름","쓰기위한목적(W)", 파일정보 정의)
# print("수학 : 0",file=score_file)
# print("영어 : 50",file=score_file)
# score_file.close()

# score_file = open("score.txt","a", encoding="utf8") #w덮어쓰기,a이어쓰기,r읽다
# score_file.write("과학 : 80")
# score_file.write("\n코딩 : 100")
# score_file.close()

# core_file = open("score.txt","r", encoding="utf8")
# print(score_file.read())
# score_file.close()

score_file = open("score.txt","r", encoding="utf8")
print(score_file.readline())#줄별로 일기, 한 줄 일고 커서는 다음줄로 이동
print(score_file.readline())
print(score_file.readline())
print(score_file.readline())
score_file.close()

#몇줄인지 모를떄
score_file = open("score.txt","r", encoding="utf8")
while true:
    line = score_file.readline()
    if not line:
        break
    print(line)
score_file.close()

#list에 처리
score_file = open("score.txt","r", encoding="utf8")
lines = score_file.readlines() #list형태로 저장
for line in lines:
    print(line, end="")

score_file.close()



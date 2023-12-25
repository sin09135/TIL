# print("대기번호:1")
# print("대기번호:2")
# print("대기번호:3")
# print("대기번호:4")

# for  waiting_no in [0,1,2,3,4]:
#     print("대기번호 : {0}".format(waiting_no))
# #리스트내의 값들이 처음부터 끝까지 나오고 종료
# #순차적으로 진행할떄는 range 가능
# for  waiting_no in range(5): # 0,1,2,3,4
#     print("대기번호 : {0}".format(waiting_no))

# #range(1,6) 1부터 6미만

# starbucks = ["아이언맨","토르","아이엠 그루트"]
# for customer in starbucks: # starbucks 안에 있는 사람을 부른다.
#     print("{0}, 커피가 준비되었습니다.".format(customer))


#while
# while (조건) 조건에 맞을 때까지 반복해라
# customer = "토르"
# index = 5 #다섯번 확인하기 위해서

# while index >= 1:
#     print("{0}, 커피가 준비 되었습니다.{1} 번 남았어요".format(customer, index)) #{0}에는 customer가 {1}은 index
#     index -= 1 #횟수를 줄여나감
#     if index == 0:
#         print("커피는 폐기처분되었습니다.")

# customer = "아이언맨" #손님이 나올떄까지 계속 호출
# index = 1
# while true:
#     print("{0}, 커피가 준비 되었습니다. 호출 {1}회".format(customer, index))
#     index += 1

customer = "토르"
person = "unknown"

while person != customer :
    print("{0}, 커피가 준비 되었습니다.".format(customer))
    person = input("이름이 어떻게 되세요?")
#토르가 오면 반복문 탈출

    




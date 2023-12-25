#continue 다음 반복을 계속 실행하라
#break  반복문 바로 탈출


absent = [2,5] # 결석
no_book = [7]
for student in range(1,11):
    if student in absent:
        continue 
    elif student in no_book:
        print("오늘 수업 여기까지.{0}는 교무실로 따라와".format(student))
        break #다음 반복문이 있어도, 반복문 바로 탈출
    print("{0}, 책을 읽어봐".format(student))
 
#한줄 for
# 출석번호가 1,2,3,4 앞에 100을 붙이기로 함
student =[1,2,3,4,5]
print(student)
student = [i+100 for i in student] # student에 있는 i 들을 불러서 100을 더함
print(student)

#학생이름을 길이로 변환
students = ["iron man", "thor","i am groot"]
students = [len(i) for i in students]
print(students)

#학생이름을 대문자로 별환
studentss = ["iron man", "thor","i am groot"]
studentss = [i.upper() for i in studentss]
print(studentss)

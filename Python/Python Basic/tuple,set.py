#튜플은 리스트에 비해 변경, 업데이트 불가이지만, 속도가 빠름
menu = ("돈까스", "치즈까스") #()
print(menu[0]) #인덱스 넣어줌(리스트도 똑같음)
print(menu[1])

#menu.add("생선까스") #에러뜸 add 사용 불가

# name = "김종국"
# age = 20
# hobby = "코딩"
# print(name, age, hobby)

name, age, hobby = ("김종국","20","코딩") #서로 다른 변수에 다른 값 한번에 가능
print(name, age , hobby)

#set(집합)
#중복 X 순서 X
my_set = {1,2,3,3,3}
print(my_set)

java = {"유재석", "김태호", "양세형"}
python = set(["유재석","박명수"]) # 이 방법도 가능 리스트로 먼저 만들고 set으로 앞뒤를 감싸줌

#교집합(자바와 파이썬 둘다 가능한 사람)
print(java & python) 
print(java.intersection(python))

#합집합
print(java | python)
print(java.union(python)

#차집합( 자바는 할 수 있지만 파이썬은 할 줄 모르는 개발자)
print(java - python)
print(java.difference(python))

#python 할 줄 아는 사람이 늘어남
python.add("김태호")
print(python)

#java를 잊었어요
java.remove("김태호")

#자료구조의 변경
#커피숍
menu = {"커피", "우유","주스"} #집합
print(menu, type(menu))

menu = list(menu) #set이 list로 바뀜
print(menu, type(menu))

menu = tuple(menu)
print(menu, type(menu)) #set이 tuple로 바뀜




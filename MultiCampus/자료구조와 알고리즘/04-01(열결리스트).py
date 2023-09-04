## 함수 
class Node(): # 클래스는 대문자로 시작(관례)
    def __init__(self):
        self.data = None
        self.link = None
    

## 전역 변수 


## 메인
node1 = Node()
node1.data = '다현'

node2 = Node()
node2.data = '정연'
node1.link = node2

node3 = Node()
node3.data = '쯔위'
node2.link = node3

node4 = Node()
node4.data = '사나'
node3.link = node4

node5 = Node()
node5.data = '지효'
node4.link = node5

newNode = Node()
newNode.data = '재남'
newNode.link = node2.link
node2.link = newNode

node2.link = node3.link
del(node3)

current = node1
print(node1.data)


current = node1
print(code1.data)
while (current.link != Node) :
    current = current.link
    print(current.data, end = ' ')
print()

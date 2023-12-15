import re

p = re.compile("s.n")  
# .(s.n) : 하나의 문자를 의미 ex) sun, son (o)
# ^(^in) : 문자열의 시작 ex) install, inside(o)
# $($ve) : 문자열의 끝 ex) save, curve (o)

def print_match(m):

    if m:
        print("m.group():" ,m.group()) # 일치하는 문자열 반환
        print("m.string():" ,m.string) # 입력받은 문자열 반환
        print("m.start():" ,m.start()) # 일치하는 문자열의 시작 index
        print("m.end():" ,m.end()) # 일치하는 문자열의 끝 index
        print("m.span():" ,m.span()) # 일치하는 문자열의 시작 / 끝 index

    else:
        print('매칭되지 않음')
        
m = p.match("sun") # match : 처음부터 일치하는지 확인
print_match(m)

m = p.search("sunny") # search : 주어진 문자열 중에 일치하는게 있는지 확인
print_match(m)

lst = p.findall("sunny") # findall : 일치하는 모든 것을 리스트 형태로 반환
print(lst)
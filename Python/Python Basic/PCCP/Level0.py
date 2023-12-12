## 문자열 뒤에 n 글자
## 문자열 my_string과 정수 n이 매개변수로 주어질 때, my_string의 뒤의 n글자로 이루어진 문자열을 return 하는 solution 함수를 작성해 주세요.

def solution(my_string, n):
    answer = ''
    answer = my_string[-n:]
    
    return answer

## 피타고라스
a = int(input())
c = int(input())

b_square = sqrt(c^2 - a^2)
print(b_square)
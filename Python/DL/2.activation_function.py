#%% 1. 간단한 구현
# AND 게이트
def AND(x1, x2):
    w1, w2, theta = 0.5,0.5,0.7
    tmp = x1*w1 + x2*w2
    if tmp <= theta:
        return 0
    elif tmp > theta:
        return 1

print(AND(1,0))
print(AND(0.7,0.5))
print(AND(2,3))
    
#%% 2. 가중치와 편향 도입
import numpy as np
x = np.array([0,1])
w = np.array([0.5, 0.5])
b = -0.7 # 편향
print(np.sum(w*x))
print(np.sum(w*x) + b)
## 넘파이 배열끼리의 곱셈은 두 배결의 원소 수가 같다면 각 원소끼리 곱함

def AND(x1, x2):
    x = np.array([x1, x2]) # 입력값
    w = np.array([0.5, 0.5]) # 가중치
    b = -0.7 # 편향
    tmp = np.sum(x*w) + b
    if tmp <= 0:
        return 0
    else:
        return 1

## 가중치 w1,w2 : 각 입력 신호가 결과에 주는 영향력(중요도)를 조절
## 편향 b : 뉴런이 얼마나 쉽게 활성화 되느냐를 조절
#%% 3. NAND 게이트, OR 게이트
## AND 게이트와는 가중치의 부호만 다르다.
## 3 게이트는 모두 같은 구조의 퍼셉트론이고, 차이는 가중치의 값뿐이다..
def AND(x1, x2):
    x = np.array([x1, x2]) # 입력값
    w = np.array([0.5, 0.5]) # 가중치
    b = -0.7 # 편향
    tmp = np.sum(x*w) + b
    if tmp <= 0:
        return 0
    else:
        return 1

def NAND(x1, x2):
    x = np.array([x1, x2]) # 입력값
    w = np.array([-0.5, -0.5]) # 가중치
    b = 0.7 # 편향
    tmp = np.sum(x*w) + b
    if tmp <= 0:
        return 0
    else:
        return 1

def OR(x1, x2):
    x = np.array([x1, x2]) # 입력값
    w = np.array([0.5, 0.5]) # 가중치
    b = -0.2 # 편향
    tmp = np.sum(x*w) + b
    if tmp <= 0:
        return 0
    else:
        return 1
print(OR(1,0))
print(OR(0,0))
print(OR(0,1))
# %% XOR 배타적논리합 -> 1이 하나일 때만 1 출력
## OR 게이트 처럼 직선 하나로 나누기가 불가능-> 곡선이라면 나눌 수가 있다.
## 따라서, 다층 퍼셉트론으로 층을 하나 더 쌓아서 XOR 게이트를 표현

def XOR(x1,x2):
    s1 = NAND(x1, x2)
    s2 = OR(x1,x2)
    y = AND(s1, s2)
    return y

print(XOR(0,0))
print(XOR(1,0))
print(XOR(0,1))
print(XOR(1,1))
# %%
## 퍼셉트론은 입출력을 갖춘 알고리즘이다.
## 퍼셉트론에서는 가중치와 편향을 매개변수로 설정한다.
## 퍼셉트론으로 AND, OR, NAND 논리회로를 표현할 수 있다.
## XOR 은 단층 퍼셉트론으로는 구현할 수 없다 -> 다층 퍼셉트론 사용
## 단층 퍼셉트론은 선형 영역, 다층 퍼셉트론은 비선형 영역 포현 가능
## 이론 상 다층 퍼셉트론 만으로도 컴퓨터를 표현할 수 있다.

#%% 3.신경망 이론
# 활성화 함수
## 활성화 함수 : 임계값을 경계로 출력이 바뀜
## 퍼셉트론에서의 활성화 함수 -> 계단 함수
## 신경망에서의 활성화 함수 -> 시그모이드 함수
## 퍼셉트론과 신경망의 주된 차이 : 활성화 함수
def step_function(x):
    if x > 0:
        return 1
    else:
        return 0
## x 는 실수만 받아들임 -> 넘파이 배열을 인수로 넣을 수 없음

# 넘파이 배열도 지원하도록 수정한 코드
def step_function(x):
    y = x > 0
    return y .astype(np.int)

#%%
import numpy as np
import matplotlib.pyplot as plt

def step_function(x):
    return np.array(x > 0, dtype=int)

x = np.arange(-5.0, 5.0, 0.1)
y = step_function(x)

plt.title('step')
plt.plot(x, y)
plt.ylim(-0.1, 1.1)
plt.show()

# %% 시그모이드 함수
def sigmoid(x):
    return 1/(1+np.exp(-x))

x = np.arange(-5.0, 5.0, 0.1)
y = sigmoid(x)
plt.plot(x,y)
plt.ylim(-0.1,1.1)
plt.title('sigmoid')
plt.show()
# %% 계단함수와 시그모이드 함수
# 계단 함수 : 0,1만 돌려줌 
# 시그모이드 함수 : 실수를 돌려줌(흘러온 물의 양에 비례해 흐르는 물의 양을 조절)
# 공통점 : 입력이 중요하면 큰 값을 출력, 입력이 중요하지 않으면 작은 값을 출력
# 공통점 : 비선형 함수

#%% Relu함수
## 입력이 0을 넘으면 그 입력을 그대로 출력, 0이하면 0을 출력
import matplotlib.pyplot as plt
def relu(x):
    return np.maximum(0,x)

x = np.arange(-5.0,5.0,0.1)
y = relu(x)
plt.plot(x,y)
plt.ylim(-0.1,1.1)
plt.title('relu')
plt.show()

#%% 행렬 곱
a = np.array([[1,2],[3,4]])
b = np.array([[5,6],[7,8]])
print(np.dot(a,b))
# %%
## 3층 신경망 구현 
# 가중치W(대문자)
import numpy as np

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def identity_function(x):
    return x

def init_network():
    network = {}
    network['W1'] = np.array([[0.1, 0.3, 0.5], [0.2, 0.4, 0.6]])
    network['b1'] = np.array([0.1, 0.2, 0.3])
    network['W2'] = np.array([[0.1, 0.4], [0.2, 0.5], [0.3, 0.6]])
    network['b2'] = np.array([0.1, 0.2])
    network['W3'] = np.array([[0.1, 0.3], [0.2, 0.4]])
    network['b3'] = np.array([0.1, 0.2])

    return network

def forward(network, x):
    W1, W2, W3 = network['W1'], network['W2'], network['W3']
    b1, b2, b3 = network['b1'], network['b2'], network['b3']

    a1 = np.dot(x, W1) + b1
    z1 = sigmoid(a1)
    a2 = np.dot(z1, W2) + b2
    z2 = sigmoid(a2)
    a3 = np.dot(z2, W3) + b3
    y = identity_function(a3)

    return y

network = init_network()
x = np.array([1.0, 0.5])
y = forward(network, x)
print(y)


# %% 소프트 맥스 함수(분류, 어느 클래스에 속할 확률 계산)
# 주의점 큰 값을 계산할 시 문제 발생
a = np.array([1010,1000,999])
print(np.exp(a)/np.sum(np.exp(a))) # nan,nan,nan 값이 나옴(제대로 계산 x)

c= np.max(a)
np.exp(a-c)/np.sum(np.exp(a-c))

def softmax(a):
    c = np.max(a)
    exp_a = np.exp(a-c) # 오버플로 대책
    sum_exp_a = np.sum(exp_a)
    y = exp_a/sum_exp_a

    return y
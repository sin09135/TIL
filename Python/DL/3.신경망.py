# 활성화 함수
## 활성화 함수 : 임계값을 경계로 출력이 바뀜
## 퍼셉트론에서의 활성화 함수 -> 계단 함수
## 신경망에서의 활성화 함수 -> 시그모이드 함수
## 퍼셉트론과 신경망의 주된 차이 : 활성화 함수
def step_fuction(x):
    if x > 0:
        return 1
    else:
        return 0
## x 는 실수만 받아들임 -> 넘파이 배열을 인수로 넣을 수 없음

def step_function(x):
    y = x > 0
    return y.astype(np.int)

#%%
import numpy as np
def softmax(a):
    c = np.max(a)
    exp_a = np.exp(a - c)
    sum_exp_a = np.sum(exp_a)
    y = exp_a / sum_exp_a

    return y

a = np.array([0.2, 0.4, 0.7])
y = softmax(a)
print(y)
# %%

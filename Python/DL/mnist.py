# mnist 데이터셋 -> 학습과정 생략, 추론과정만 구현

#%%
#%%
import sys, os
sys.path.append(os.pardir) # 부모 디렉토리 파일을 가져올 수 있도록 설정
from dataset.mnist import load_mnist

#%% 
# 데이터 로드
(x_train, t_train), (x_test, t_test) = \
load_mnist(flatten = True, normalize= False) 
# normalize 입력 이미지의 픽셀 값을 정규화(True : 0.0 ~ 0.1, False : 0~255)
# Flatten : 1차원 배열로 만들지 설정

# 출력
print(x_train.shape)  # (60000, 784)
print(t_train.shape)  # (60000,)
print(x_test.shape)   # (10000, 784)
print(t_test.shape)   # (10000,)

# %%
from PIL import Image
import numpy as np

def img_show(img):
    pil_img = Image.fromarray(np.uint8(img))
    pil_img.show()

img = x_train[0]
label = t_train[0]

img = img.reshape(28,28)
print(img.shape)

img_show(img)
# %%

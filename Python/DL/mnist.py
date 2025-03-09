# mnist 데이터셋 -> 학습과정 생략, 추론과정만 구현
#%%
import sys, os
sys.path.append(os.pardir) # 부모 디렉토리 파일을 가져올 수 있도록 설정
from dataset.mnist import load_mnist


# %%
import tensorflow as tf
from tensorflow.keras import datasets

# 데이터 로드
(x_train, t_train), (x_test, t_test) = datasets.mnist.load_data()

# 평탄화 작업
# Flatten (1D로 변환) 및 정규화
x_train = x_train.reshape(x_train.shape[0], -1).astype('float32') / 255.0
x_test = x_test.reshape(x_test.shape[0], -1).astype('float32') / 255.0

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

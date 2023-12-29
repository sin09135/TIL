#pickle 
# 프로그램상에서 사용하고 있는데이터 파일의 형태로 저장
#누군가가 또 쓸수 있음

# import pickle
# profile_file = open("profile.pickle","wb") #쓰기 #pickle 에서는 꼭 b
# profile = {"이름":"박명수","나이":30,"취미":["축구","골프","코딩"]}
# print(profile)
# # pickle.dump(profile, profile_file) #profile에 있는 정보를 file에 저장
# # profile_file.close()

# profile_file = open("profile.pickle", "rb") #읽기로 가져옴
# profile = pickle.load(profile_file) #file에 있는 정보를 profile로 불러오기
# print(profile)
# profile_file.close()

#with
import pickle

with open("profil.pickle","rb") as profile_file: #prifile.pickle 이라는 파일을 열고, 이걸 profile_file에 저장
    print(pickle.load(profile_file)) #pickle.load 를 이용해서 profile_file 을 불러와서 출력. close는 필요없음

#
with open("study.txt","W","r",encoding="utf8") as study_file:
    print(study_file.read())

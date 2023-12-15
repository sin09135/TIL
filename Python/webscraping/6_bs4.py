import requests
from bs4 import BeautifulSoup


# 네이버 웹툰
url = "http://comic.naver.com/index"
res = requests.get(url)
res.raise_for_status()

soup = BeautifulSoup(res.text, "lxml")
print(soup.title)
print(soup.title.get_text()) # sub 객체의 title element 의 텍스트를 출력
# print(soup.a) # soup 객체에서 처음 발견되는 a element 출력
# print(soup.attrs) # a element 의 속성 정보
# print(soup.a['href']) # a element 의 href 속성 '값' 정보를 출력

# class가 "component_wrap"인 div 요소 찾기
# class가 "component_wrap"인 div 요소 찾기
component_wrap_div = soup.find("span", class_= "AsideList__content_list--FXDvm")
print(component_wrap_div)

where_title = soup.find("span", string = "김부장")
print(where_title)

if component_wrap_div:
    # 정상적으로 div 요소를 찾았을 때만 작업 수행
    webtoons = component_wrap_div.find_all("ul", class_="AsideList__item--i30ly")

    for webtoon in webtoons:
        title = webtoon.find("span", class_="ContentTitle__title--e3qXt").get_text()
        author = webtoon.find("a", class_="ContentAuthor__author--CTAAP").get_text()
        print("제목:", title)
        print("작가:", author)
        print("---")
else:
    print("component_wrap div 요소를 찾지 못했습니다.")



# -*- coding:utf-8 -*-
from bs4 import BeautifulSoup

def main():
    # index.html 을 불러와서 BeautifulSoup 객체 초기화
    # 웹에서 응답을 할 때, HTML, XML, JSON 그 외 여러가지 방식들이 존재
    soup = BeautifulSoup(open("html/index.html"), "html.parser")
    print(soup)

    print(soup.title)
    print(soup.title.string)
    print(soup.p)
    all_p_tags = soup.find_all('p')  
    second_p_tag = all_p_tags[1] 
    content = second_p_tag.get_text()
    print(content)

    #11






if __name__ == "__main__":
    main()


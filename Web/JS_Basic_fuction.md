# JS 웹 개발 기본 지식_함수

- HTML, CSS 가 JS가 기본적으로 쓰임
- 자바스크립트 스타일 가이드 준수하여 코드 네임 작성해야 함.



## 사용자 정의 함수 - 변수 선언

> 변수 선언

### 1) var

- 변수 재선언 가능

- 호이스팅 발생

  

#### (1) 지역변수 선언 - error

```javascript
   <script>
        function addNumber() {
            var sum = 10 + 20; // 지역변수 선언 
            multi = 10 * 20 // 전역변수 선언(var 가 없으면)
        }
        addNumber();
        console.log(sum) // 지역변수 불러오기  - error
  </script>
```

<img src="/Users/kimsinwoo/Downloads/js 전역변수 에러 창.png" style="zoom:33%;" />

#### (2) 전역변수 선언

```javascript
 <script>
        function addNumber() {
            var sum = 10 + 20; // 지역변수 선언 
            multi = 10 * 20 // 전역변수 선언(var 가 없으면)
        }
        addNumber();
        console.log(multi) // 전역변수 불러오기
</script>
```



#### (3)호이스팅

> 코드 실행 전, 변수 선언/함수 선언이 해당 범위의 최상단으로 끌어 올려진 것 같은 현상

```javascript
<script>
        var x = 10;
        function displayNumber(){
            // var y; 가 생략
            console.log("x is " + x);
            console.log("x is " + y); //다른 언어에서는 에러 발생
            var y = 20;

       }
</script>
```

#### (4) 변수의 재 선언과 재 할당

```javascript
<script>
       
       function addNumber(num1,num2) {
            return num1 + num2;
       }
       var sum = addNumber(20,30);
       console.log(sum);
       sum = 50; //변수 재 할당 (중복될 수 있음) -> let, const 사용
       console.log(sum)
       var sum = 100;
       console.log(sum)

</script>
```



### 2) let

- 재할당 o, 재선언 x

- 호이스팅은 발생하지만, 초기화 단계가 호이스팅되지 않아 선언 전에 변수에 접근하면 "ReferenceError"가 발생

```javascript
<script>
       
       function CalSum(n) {
            let sum = 0; //한번 나왔던 변수일 수 있으니
            for(let i = 1;i>n + 1;i++);{
                sum += i;

            }
            sum = 100; //변수 재할당
            console.log(sum)

        }
        CalSum(100);

        var x = 10;
        function displayNumber() {
            console.log("x is" + x);
            console.log("y is" + y);
            let y = 20;
        }
        displayNumber()
      

</script>
```

출력 결과

```
5050
x is 10
y is 20
```



### 3) const

- 상수 선언 시(나머지는 let)

- 재할당 x, 재선언 x

```javascript
<script>
        
        const currentYear = 2023;
        console.log(currentYear);
        const currentYear = 2024;
        console.log(currentYear);

</script>
```





**변수 선언 규칙 **

- 전역변수는 최소한으로 사용
- var 변수는 함수의 시작 부분에서 선언함
- for 문에서 카운터 변수 사용시, var 예약어 사용 안함
- 가급적이면, **let & const** 위주로 변수를 할당



## 사용자 정의 함수 - 함수 종류

### 1) 즉시 실행 함수

> 한번만 실행 하는 함수

```
<head>
    <meta charset="UTF-8">
    <title>사용자 정의 함수</title>
    <style>
        body{
            padding-top : 30px;
            text-align: center;
        }
        .accent{
            font-weight : bold;
            font-size: 1.2em;
            color : blue;

        }
    </style>
</head>
<body>
    <h1>시작해볼까요</h1>
    <p>즉시 실행 함수</p>
    <script>
        (function(){
            var userName = prompt('이름을 입력하세요')
            document.write("안녕하세요 <span class ='accent'>" + userName + "</span>님!")
        }())

    </script>
</body>
```



### 2) 익명 함수

> 이름이 없는 함수

```javascript
<script>
   var sum = function(a, b){
     return a + b;
}
document.write("함수 실행 결과 : " + sum(10, 20) ); 
</script>
```



### 3) 화살표 함수

- (매개변수) => { 함수 내용 }

```javascript
const hi = function() { return “안녕하세요?”;}
```



## 이벤트와 이벤트 처리기

- 자바스크립트의 이벤트는 주로 마우스나 키보드 사용 시
- 폼(form)에 내용을 입력할 때 발생



**주요 이벤트**

- 마우스 이벤트
- 키보드 이벤트
- 문서 로딩 이벤트
- 폼 이벤트
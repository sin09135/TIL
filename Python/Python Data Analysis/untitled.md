
# <div style="padding: 30px;color:white;margin:10;font-size:60%;text-align:left;display:fill;border-radius:10px;background-color:#FFFFFF;overflow:hidden;background-color:#CDE10F"><b><span style='color:#FFFFFF'>1 |</span></b> <b>INTRODUCTION</b></div>

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>FOREWORD</span></b></p></div>

- 최근에 (2020년만), 디지털 자산 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Bitcoin</mark>**은 단독으로 200% 이상 상승하여 새로운 최고치에 도달한 후 다시 하락했습니다.
- 이는 이 자산이 얼마나 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">휘발성</mark>** 있는지 보여주며, 이는 일반 주식과 달리 탐험하기에 더욱 흥미로운 시계열 데이터 중 하나로 만듭니다.
- 이 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">디지털 자산</mark>**이 최근 하락 후 가치가 다시 상승한 것을 보는 것은 특히 현재의 금융 상황에서 흥미롭습니다.
- 이 자산에 영향을 미칠 수 있는 여러 가지 요소가 있으며, 우리는 전통적인 주식 기반 요인만 살펴볼 것입니다.
- 이 노트북은 나만의 시계열 문제 연습 및 일반 함수/클래스 코딩을 위해 작성되었으며 관련 데이터셋은 매우 휘발성인 자산의 광범위한 데이터 가용성으로 인해 사용되었습니다.

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>DIGITAL ASSETS</span></b></p></div>

**[데이터셋 설명](https://www.kaggle.com/mczielinski/bitcoin-historical-data)** 스니펫

> Bitcoin은 익명의 Satoshi Nakamoto에 의해 2009년에 최초로 오픈 소스로 출시된 가장 오래되고 가장 잘 알려진 암호화폐입니다. Bitcoin은 신뢰할 수있는 기록 저장 기관이나 중앙 중개 업체가 필요하지 않은 공개 분산 원장 (블록 체인)에 거래가 검증되고 기록되는 분산형 디지털 교환의 역할을합니다. 거래 블록에는 이전 거래 블록의 SHA-256 암호 해시가 포함되어 있으며 따라서 모든 거래의 변경 불가능한 기록 역할을하며 "체인"되어 있습니다. 시장에서 어떤 통화/상품이든 마찬가지로 Bitcoin의 공개적인 채택 이후 Bitcoin 거래 및 금융 도구가 따라왔으며 계속 성장하고 있습니다. 여기에는 거래가 발생하는 선택한 Bitcoin 거래소에서의 1분 간격의 역사적인 Bitcoin 시장 데이터가 포함되어 있습니다. 행운을 빕니다! 


Markdown Cell 2:
<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>주가 영향 요인</span></b></p></div>

주가 예측에 유용한 특성은 <b>Tatsat et al (2020)</b>에 의해 개요로 제시된 바와 같습니다.

##### **상관된 자산**

> 조직은 경쟁사, 고객, 세계 경제, 지정학적 상황, 재정 및 통화 정책, 자본 접근 등과 같은 다양한 외부 요인에 의존하고 상호 작용합니다. 따라서 주식 가격은 다른 기업의 주식뿐만 아니라 원자재, 환율, 종합 지수 또는 고정 소득 증권과 같은 다른 자산과 상관 관계가 있을 수 있습니다.

##### **기술적 지표**

> 많은 투자자들은 기술적 지표를 따릅니다. 이동 평균, 지수 이동 평균 및 모멘텀은 가장 인기 있는 지표입니다.

##### **기술적 보고서**

> 기업의 연간 및 분기 보고서는 ROE (자기 자본 이익률) 및 P/E (주당 주가 수익률)와 같은 주요 지표를 추출하거나 결정하는 데 사용될 수 있습니다.

##### **뉴스 보도**

> 뉴스는 특정 방향으로 주식 가격을 움직일 수 있는 예정 이벤트를 나타낼 수 있습니다.

- **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">주가</mark>**에 중점을 둘 때, 변수 구축 및 조립에 대해 위에서 설명한 몇 가지 접근 방식을 사용할 수 있습니다
- **([출처](https://cryptobriefing.com/is-bitcoin-stock-commodity/))**에서 나타낸 바와 같이, <code>Bitcoin</code>은 주식이나 통화보다는 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">디지털 자산</mark>**이기 때문에 설명된 요인들이 <code>Bitcoins</code>와 관련된 분석에 완전히 관련이 있는지 여부는 분명하지 않습니다.
- 그러나 **([출처](https://www.mycryptopedia.com/best-8-bitcoin-indicators-for-cryptocurrency-trading/))**은 특히 <code>Bitcoin</code> 가격 방향성 예측에 유용한 다양한 <code>지표</code>들을 개요로 설명하고 있습니다. 이는 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">기술적 지표</mark>**가 <code>Bitcoin</code>의 시계열에서 중요한 역할을 하는 것을 보여줍니다 


Markdown Cell 3:
<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>문제 정의</span></b></p></div>

- 암호화폐 거래의 주요 단점 중 하나는 시장의 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">변동성</mark>**입니다.
- 통화 거래는 24/7 이 일어날 수 있으며 암호화 포지션을 추적하는 것은 자동화 없이는 관리하기 어려운 작업일 수 있습니다.
- 자동화 된 기계 학습 거래 알고리즘은 시장의 움직임을 예측하는 데 도움을줄 수 있으며 미래 움직임을 세 가지 범주로 분류 할 수 있습니다.

> <code>(1) 시장이 상승할 것이다 (긴 포지션을 취함)</code>, <br>
> <code>(2) 시장이 하락할 것이다 (숏 포지션 취함)</code> <br>
> <code>(3) 시장이 수평으로 움직일 것이다 (포지션을 취하지 않음)</code>.
    
    
- **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">거래 전략</mark>**을 위한 매수 (<code>value=1</code>) 또는 매도 (<code>value=0</code>) 신호를 예측하는 문제는 분류 프레임워크에서 정의됩니다. 
- 매수 또는 매도 신호는 단기 대 장기 가격을 비교함으로써 결정되며 <code>Section 2.2</code>에서 정의되었습니다.
- 데이터 수집 및 <code>feature engineering</code>은 시계열 모델 개선에 관련된 요소입니다. 
- 흥미로운 점은 전통적으로 주식 지향적인 <code>feature engineering</code> 수정이 <code>digital assets</code>에 적용 가능한지 여부 및 그렇다면 어떤지 조사하는 것입니다.
- 마지막으로, **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">모델 생성 효율성</mark>**은 각 추가된 특성이 모델의 반환 시간에 상당한 영향을 미칠 수 있기 때문에 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">고빈도 틱 데이터</mark>**를 처리할 때 훨씬 중요해집니다. 모델 정확성 및 모델 출력 반환 시간의 균형을 유지하는 것은 분명히 관리할 가치가 있습니다.

Markdown Cell 4:
<div style="padding: 30px;color:white;margin:10;font-size:60%;text-align:left;display:fill;border-radius:10px;background-color:#FFFFFF;overflow:hidden;background-color:#CDE10F"><b><span style='color:#FFFFFF'>2 |</span></b> <b>데이터셋</b></div>

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>데이터셋 읽기</span></b></p></div>

- 현재 데이터셋 : 2012년 1월부터 2020년 9월까지의 특정 비트코인 거래소에 대한 CSV 파일, <code>1분 간격 데이터</code> ([데이터셋](https://www.kaggle.com/mczielinski/bitcoin-historical-data))
- <code>timestamp</code> 특성은 <code>pytz</code> 라이브러리를 사용하여 더 일반적인 시간 인덱스로 구문 분석 할 수 있습니다.
- <code>Baseline Features</code>에는 자산의 분 단위의 <code>open</code>,<code>high</code>,<code>low</code>,<code>close</code>,<code>Volume_(BTC)</code>,<code>Volume_(Currency)</code> 및 <code>Weighted_Price</code>이 포함됩니다.
- 로드된 데이터셋에는 특정 시작 및 종료 시간 인덱스가 있으며 모델을 보지 않은 데이터에 사용하려면 데이터셋을 분할하고 확인하지 않아야 합니다. 사용된 코드는 아래에 숨겨져 있습니다.


Markdown Cell 5:
<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>데이터 부분집합 작업</span></b></p></div>

- 우리에게 제공된 지표 데이터가 많기 때문에 모델의 교육은 꽤 오래 걸릴 수 있습니다. 특히 교차 유효성 검사의 경우입니다.
- 이 노트북에서는 예측하려는 내용과 가장 관련이 있을 것으로 예상되는 <code>100,000</code> (4.5M 대비) 최근 데이터 포인트로 데이터셋을 제한해 보겠습니다.
- <code>2개월간의 교육 데이터</code>만으로는 매우 정확한 모델을 얻기에 충분하지 않을 수 있습니다 (짧은 기간이지만 상당한 데이터를 포함하므로 일부 추세를 놓칠 수 있지만, 더 강력한 PC가 있다면 더 많은 포인트를 시도할 수 있습니다).
- 물론 더 큰 데이터셋을 처리하는 데 유용한 응용 프로그램 중 하나는 <code>GPU</code> 대응 모델입니다. 
- 매우 간단하고 쉽게 사용할 수 있는 <code>XGBoost</code>의 GPU 대응 모델 예제는 [hamditarek](https://www.kaggle.com/hamditarek/market-prediction-xgboost-with-gpu-fit-in-1min?q=XGboost+GPU)에서 제공됩니다.


Markdown Cell 6:
시계열 데이터셋 2개월로 제한

Markdown Cell 7:
<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>데이터 정리</span></b></p></div>

- 결측 데이터는 시각화되었으며 특징 간에 일관되게 나타납니다.
- 거래가 발생하지 않은 기간의 지표 데이터를 채우기 위해 <code>value=0</code> (<b>무시</b>)로 적용된 단일 이벤트를 살려냅니다.
- 연속 시계열이므로 특징 <code>open</code>,<code>high</code>,<code>low</code>,<code>close</code>를 앞쪽 채우기 (<code>ffil</code>)를 사용하여 수정합니다.

Markdown Cell 8:
결측치 시각화:
결측치를 시각화하고 해당 결측치가 특성 간에 일관되게 나타나는 것을 확인합니다.
거래가 발생하지 않은 인덱스의 결측치 처리:
거래가 발생하지 않은 인덱스에 대한 데이터를 단일 이벤트 값인 0으로 채웁니다.
아마도 거래가 없는 기간 동안 해당 값을 0으로 채워 해당 시기에 거래가 없었음을 나타내려는 것으로 이해됩니다.
시계열 특성(open, high, low, close) 수정:
시계열 특성(open, high, low, close)을 시간 순서대로 연속적으로 수정하려면 전방 채우기 (ffill)를 사용합니다.
전방 채우기는 결측치를 가장 최근의 결측치가 아닌 값으로 채우는 것을 의미합니다. 이는 값이 자주 연속적이고 상관된 시계열 데이터에서 유용합니다.

Markdown Cell 9:
데이터프레임(df_tr)에서 각 열의 결측치 비율을 계산하고, 이를 시각화하기 위해 막대 그래프를 생성

Markdown Cell 10:
Prediction with non events <code>.fillna(0)</code> can be interesting to include in signal modelling, but excluded here to have a more visible stock fluctuation history.
이벤트가 발생하지 않은 경우의 예측은 .fillna(0)을 사용하여 0으로 채우는 것이 모델링에서 흥미로울 수 있지만, 여기서는 주식 가격의 변동 내역을 더 명확하게 보기 위해 제외하였다

Markdown Cell 11:
# <div style="padding: 30px;color:white;margin:10;font-size:60%;text-align:left;display:fill;border-radius:10px;background-color:#FFFFFF;overflow:hidden;background-color:#CDE10F"><b><span style='color:#FFFFFF'>3 |</span></b> <b>데이터 탐색</b></div>

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;">
    <p style="padding: 5px;color:white;text-align:left;">
        <b><span style='color:#CDE10F'>기술 통계</span></b>
    </p>
</div>

데이터셋의 숫자형 값에 대한 통계를 조사해 봅시다.


Markdown Cell 12:
<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;">
    <p style="padding: 5px;color:white;text-align:left;">
        <b><span style='color:#CDE10F'>타겟 변수</span></b>
    </p>
</div>

- 예측 변수 <code>signal</code>을 정의해야 합니다. 이는 <code>Close</code> 특성을 사용하여 <code>.rolling</code> 및 <code>.mean()</code>을 통해 수행됩니다.
- 단기 (윈도우) 이동 평균인 <code>SMA1</code> 및 장기 (윈도우) 이동 평균인 <code>SMA2</code>를 사용하여 대상 변수인 <code>signal</code>을 생성합니다.
- 거래 전략은 다음과 같습니다. <code>Short Term (SMA1)</code> > <code>Long Term (SMA2)</code>인 경우 신호 값은 1 <code>(매수)</code>로 설정되고, 그렇지 않으면 0 <code>(매도)</code>로 설정됩니다.
- <code>Short Term (SMA1)</code> 및 <code>Long Term (SMA2)</code> 이동 평균 값은 각각 <b>윈도우 값이 10 및 60</b>으로 설정되어 있으며, 이는 임의의 값이며 결과에 영향을 미칠 수 있습니다. 이상적으로는 최적의 값 찾기 위해 최적화 연구를 수행해야 합니다.
</p>


Markdown Cell 13:
- 상대적으로 균일한 (매수/매도) 분포인 <code>signal</code> 타겟 변수가 있습니다 (40,000건/38,000건).
- 이 문제에서는 <code>클래스 불균형</code>과 관련된 문제에 대해 강조할 필요가 없습니다.
- 이진 분류 모델의 평가 지표로는 ROC 및 PR 곡선보다는 간단한 지표인 <code>정확도, 재현율, 정밀도</code> 같은 메트릭이 충분할 수 있습니다.

Markdown Cell 14:
<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;">
    <p style="padding: 5px;color:white;text-align:left;">
        <b><span style='color:#CDE10F'>데이터셋 시계열 시각화</span></b>
    </p>
</div>

훈련 데이터 기간 동안의 전체 자산 가격 히스토리와 연관된 <code>signal</code>을 시각화해 봅시다.

Markdown Cell 15:
- <code>가중치가 적용된</code> 자산 가격의 일반적인 상승 트렌드를 주목하는 것이 흥미로운데, 이 기간의 시작부터 9,200에서 몇 달 사이에 11,730까지 상승했습니다.
- 시각화가 쉽지 않지만, 신호 (모델링할 대상)도 플로팅되어 있습니다. 이 짧은 기간 동안에 얼마나 단기 및 장기 이동 평균이 교차되는지 관찰할 수 있습니다.

Markdown Cell 16:
단기 및 장기 이동 평균 값이 교차되는 기간이 꽤 많음을 볼 수 있습니다. 심지어 <b>8시간</b> 동안에도 관찰된 기간 동안 비용이 <code>9,240에서 9,400</code> 범위로 변동되었으며, 이는 고도로 변동성이 높은 자산을 나타냅니다.


Markdown Cell 17:
### <b><span style='color:#CDE10F'> 3.1 |</span> 기준 모델 특성</b>

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;">
    <p style="padding: 5px;color:white;text-align:left;">
        <b><span style='color:#CDE10F'>기준 특성 상관관계</span></b>
    </p>
</div>

기준 용어를 정의해 봅시다. 데이터셋에서 사용 가능한 특성인 **open**, **close** 등입니다.
- 현재 특성인 <code>open</code>,<code>high</code>,<code>low</code>,<code>close</code>,<code>volumes</code>,<code>weighted_price</code>의 선형 상관관계 값은 대상 변수에 대해 매우 미미합니다.
- 이는 여러 가지를 나타낼 수 있습니다. <code>높은 비선형성</code>, <code>정적 값에 대한 안정적인 진동</code> (원형 산점도) 또는 아마도 이러한 특성이 대상인 <code>signal</code>을 모델링하는 데 가장 이상적이지 않을 수 있으며 개선이 필요할 수 있습니다. 따라서 <code>특성 엔지니어링</code>에 주의가 기울어집니다.

Markdown Cell 18:
<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;">
    <p style="padding: 5px;color:white;text-align:left;">
        <b><span style='color:#CDE10F'>피쳐 엔지니어링</span></b>
    </p>
</div>

- 소개에서 언급한대로, 현재 문제에서는 <code>기술 지표</code>에 중점을 두어 <code>특성 엔지니어링</code> 접근 방식의 일부로 대한 더 많은 관련 특성을 <code>특성 행렬</code>에 도입하려고 합니다.
- (디지털 자산의 맥락에서 특히 흥미로운 것은) 어떤 특성이 모델의 성능에 영향을 미치는지, 그렇다면 어떤 영향을 미치는지를 알아보는 것입니다.

<b>구체적으로:</b>

> - <code>이동 평균</code> : 노이즈의 양을 줄이는 방식으로 가격 움직임의 추세를 나타냅니다. <br>
> - <code>스토캐스틱 오실레이터 %K 및 %D</code> : 스토캐스틱 오실레이터는 특정 종가를 일정 기간 동안의 가격 범위와 비교하는 모멘텀 지표입니다. %K 및 %D는 느린 및 빠른 지표입니다. <br>
> - <code>상대 강도 지수(RSI)</code> : 최근 가격 변동의 크기를 측정하여 주식이나 다른 자산의 과매수 또는 과매도 상태를 평가하는 모멘텀 지표입니다. [0,100] 범위. <b>자산 -> 70: 과매수</b>. <b>자산 -> 30: 과소매도 & 저평가된 자산</b>.<br>
> - <code>변동률(ROC)</code>: 현재 가격과 n 기간 전 가격 사이의 백분율 변화를 측정하는 모멘텀 오실레이터입니다. <b>높은 ROC 값</b>을 가진 자산은 과매수일 가능성이 높으며, <b>낮은 ROC</b>은 과소매도일 가능성이 높습니다.<br>
> - <code>모멘텀 (MOM)</code> : 가격이나 거래량의 가속도 비율입니다. <br>

모두 다양한 정도의 영향을 미칠 수 있으며, 이를 사용하여 대상 변수 <code>signal</code>을 모델링할 수 있습니다.


Markdown Cell 19:
### <b><span style='color:#CDE10F'> 3.2 |</span> Updated Feature Model Features</b>

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;">
    <p style="padding: 5px;color:white;text-align:left;">
        <b><span style='color:#CDE10F'>업데이트된 특성 선형 상관관계</span></b>
    </p>
</div>

- 새로운 Features 인 <code>MA</code>,<code>EMA</code>,<code>MOM</code>,<code>RSI</code>,<code>%K/%D</code>를 생성한 후,
- 이러한 새로운 Features와 대상 변수 간의 선형 상관관계를 조사하고 <code>기준 데이터셋</code>의 특성과 비교해 봅시다.


Markdown Cell 20:
- <code>피쳐 엔지니어링</code> 결과로 생성된 선형 상관관계가 상당히 높은 특성 그룹을 볼 수 있습니다.
- 사용된 경우 기준 데이터셋 특성이 대상 변수의 변화에 거의 영향을 미치지 않을 것으로 예상됩니다.
- 반면에 새롭게 생성된 특성은 상당히 다양한 상관관계 값을 가지고 있으며, 상당히 중요한 것은 대상 변수인 <code>signal</code>과 너무 높은 상관관계를 가지지 않는다는 것입니다.


Markdown Cell 21:
<code>Feature matrix</code>에 함수를 적용한 후, 결측치를 다시 확인해야 합니다.


Markdown Cell 22:
# <div style="padding: 30px;color:white;margin:10;font-size:60%;text-align:left;display:fill;border-radius:10px;background-color:#FFFFFF;overflow:hidden;background-color:#CDE10F"><b><span style='color:#FFFFFF'>4 |</span></b> <b>모델 생성</b></div>

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;">
    <p style="padding: 5px;color:white;text-align:left;">
        <b><span style='color:#CDE10F'>평가 함수</span></b>
    </p>
</div>


명확한 <code>대상 변수</code> 및 <code>특성 행렬</code>을 정의한 후에는 다음을 검토해 봅시다:<br><br>
- df_tr1/df_te1 : <code>자산과 관련된 기준 특성의 훈련/테스트 데이터프레임</code>
- df_tr2/df_te2 : <code>특성 엔지니어링 단계에서 생성된 새로운 특성의 훈련/테스트 데이터프레임</code>

그리고 아래의 평가 함수를 사용하여 대상 변수 <code>signal</code> (시장 방향성)을 예측하기 위해 모델을 생성할 수 있습니다.

<b>평가 함수는 (아래에 숨겨져 있습니다):</b><br><br>
평가 함수의 목적은 모델이 다양한 데이터 분할 및 평가 방법에서 얼마나 잘 수행되는지를 평가하는 것입니다.

<b>(1)</b> 이 함수는 <code>특성 행렬 X</code> 및 <code>대상 변수 y</code>가 모두 포함된 <code>데이터프레임</code>을 가져옵니다. <br>
<b>(2)</b> 데이터는 <code>train_df</code> 및 <code>eval_df</code>로 분할됩니다. <br>
<b>(3)</b> 가져온 데이터프레임의 5-Fold <code>교차 검증</code>을 통해 모델이 훈련 데이터에서 얼마나 잘 수행되는지에 대한 정보를 얻습니다 (작은 덩어리와 큰 덩어리 모두에서).<br>
<b>(4)</b> 표준 Two-Way Split (데이터 섞기 없이)이 수행되고, <code>X_train/y_train</code> 및 <code>X_eval/y_eval</code>에 대해 훈련됩니다.


Markdown Cell 23:
### <b><span style='color:#CDE10F'> 4.1 |</span> BASELINE FEATURE MODEL EVALUATION</b> 
Baseline Feature:
해당 자산의 분당 open, high, low, close, Volume_(BTC), Volume_(Currency), Weighted_Price


Markdown Cell 24:
- **<span style='color:#CDE10F'>cross_val_score</span>**가 대략 **<span style='color:#CDE10F'>accuracy = 0.5</span>** 지역에 머무르고 있습니다. 이는 하나의 자산과 관련된 **<span style='color:#CDE10F'>기준 특성</span>**만 사용하는 것이 정확한 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">자산 방향성</mark>**을 예측하는 데 적합하지 않음을 시사합니다.
- 대부분의 모델은 **<span style='color:#CDE10F'>교차 검증 점수</span>**보다 더 높은 **<span style='color:#CDE10F'>훈련 점수</span>**를 기록하는 경향이었습니다.
- 매우 적은 추정자로 심지어 과적합된 상태에서 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">DecisionTreeClassifier</mark>** 및 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">RandomForest</mark>**가 매우 높은 점수를 기록할 수 있는 것은 흥미로웠습니다.
- 이는 트리 기반 모델이 이 문제에서 매우 유용할 수 있으며 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">kNN</mark>**도 교차 검증 점수가 낮기 때문에 훈련 데이터에서 너무 적합한 모델 중 하나로 추가될 수 있음을 시사합니다.

**<span style='color:#CDE10F'>훈련 및 평가 시간</span>**도이 문제에서 상당히 중요합니다:
- (100k/4.5M)만 사용했을 때, 심지어 7개의 특성만 사용한 고급 모델(<code>esp.GBM 및 ANN</code>)의 비용은 매우 높습니다.
- 더 고급 모델은 훈련 시간을 비교 가능한 수준으로 줄이기 위해 크게 조정되어야 했기 때문에 특성 선택 프로세스를 최적화하는 것이 바람직합니다.
- **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">XGB</mark>** 및 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">CATBoost</mark>**는 꽤 빠르게 작동하여 고급 모델로 즉시 사용하기에 매우 최적화되어 있는 것으로 나타났습니다.
- **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">RandomForest</mark>**는 XGB와 유사한 모델임에도 불구하고 훨씬 느립니다.


Markdown Cell 25:
### <b><span style='color:#CDE10F'> 4.2 |</span> Updated feature model evaluation</b> 

우리는 <code>2.5 섹션</code>에서 <code>feature engineering</code>으로 새로운 특성을 만들었습니다. 업데이트된 특성인 <code>df_feat</code> 데이터프레임을 생성했으니 이러한 새로운 특성을 사용하여 다시 시도해 봅시다.

Markdown Cell 26:
- **<span style='color:#CDE10F'>정확도</span>** 점수에서 **<span style='color:#CDE10F'>기준 모델</span>**과 비교했을 때 매우 큰 향상이 보입니다.
- **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">LinearDiscriminantAnalysis()</mark>**는 꽤 잘 수행되었습니다. 훈련 세트뿐만 아니라 교차 검증에서도 놀랍게도 가장 빠른 접근 중 하나입니다. 이로 인해 대규모 데이터셋에 대한 가장 효율적인 접근 중 하나가 됩니다.
- 높은 점수를 기록한 모델 중 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">LDA</mark>** 뿐만 아니라 더 고급 모델들인 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">GBM</mark>**,**<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">XGB</mark>**,**<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">CAT</mark>**,**<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">RF</mark>** 등도 놀랍지 않게 높은 성능을 보여줍니다.
- **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">kNN()</mark>** 및 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">GaussianNB()</mark>** 비지도 모델은 지도 학습 모델과 비교했을 때 약간 더 낮은 성능을 보였습니다.


Markdown Cell 27:

# <div style="padding: 30px;color:white;margin:10;font-size:60%;text-align:left;display:fill;border-radius:10px;background-color:#FFFFFF;overflow:hidden;background-color:#CDE10F"><b><span style='color:#FFFFFF'>5 |</span></b> <b>MODEL EFFICIENCY OPTIMISATION</b></div>

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>UTILISING DIMENSIONALITY REDUCTION</span></b></p></div>

- 문제의 목표를 달성하려고 할 때 마주치는 큰 문제 중 하나는 전체 데이터셋에 대한 많은 틱 데이터(매 분)입니다. 이로 인해 계산 비용이 꽤 높아집니다.
- **<span style='color:#CDE10F'>피처 행렬</span>**이 피처 및 인스턴스 수에 의존하므로 심지어 하나의 불필요한 피처를 제거하면 계산 비용에 뚜렷한 영향을 미칠 것입니다.
- 따라서 모델 정확도와 훈련/예측 속도 간의 문제 균형을 맞추기 위해 가능한 한 많은 불필요한 피처를 제거하는 것이 매우 중요합니다.

<b>두 가지 접근 방식을 살펴보겠습니다:</b>

- <b>(1) 피처 중요도 평가를 통한 차원 축소 (수동적인 접근)</b>

> 이것은 모든 라이브러리가 결합되지 않기 때문에 더 수동적인 프로세스입니다. 그러나 모든 접근 방식 사이에서 공통점을 찾아서 하나의 <code>피처 중요도</code> 평가 접근 방식으로 결합하여 식별하고 평가하며 피처를 제거하여 접근 속도를 높일 수 있도록 해 보겠습니다.

- <b>(2) 비지도 학습 알고리즘을 사용한 차원 축소 (자동화된 프로세스)</b>

> <code>sklearn</code> 라이브러리에는 우리에게 제공되는 강력한 <code>차원 축소</code> 알고리즘의 집합이 있습니다. 유일한 문제는 결과적인 피처의 의미를 설명하는 것이 약간 문제가 될 수 있다는 것입니다.


Markdown Cell 28:
- 특정한 훈련된 모델들의 **<b>피처 중요도</b>** (FI)를 살펴볼 수 있습니다. 어떤 피처가 얼마나 중요한지를 이해하기 위해.
- 이러한 간소화된 함수를 사용하여 다양한 접근 방식과 최적화된 라이브러리에 의존하여 피처 중요도를 신속하게 평가할 수 있습니다. <b>function</b> <code>feature_importance</code>에는 다음이 포함됩니다:

> - **<span style='color:#CDE10F'>abs()</span>** 함수를 사용한 **<span style='color:#CDE10F'>선형 상관 관계</span>**
> - Catboost Regression 모델의 **<span style='color:#CDE10F'>SHAP 값</span>** (n_est)
> - **<span style='color:#CDE10F'>RandomForest Regressor</span>** (n_est)
> - **<span style='color:#CDE10F'>XGBoost Regressor</span>** (n_est)
> - **<span style='color:#CDE10F'>CatBoost Regressor</span>** (n_est)
> - **<span style='color:#CDE10F'>SelectKBest</span>** (k)

<div style="color:white;display:fill;border-radius:8px;font-size:100%; letter-spacing:1.0px;"><p style="padding: 5px;color:white;text-align:left;"><b><span style='color:#CDE10F'>추가 조정</span></b></p></div>

- 개별 점수는 <code>MinMaxScaler()</code>를 사용하여 결합 및 조정되며 플로팅됩니다.
- y 축은 총 점수를 나타내며 (높은 점수가 더 좋음, 최대 -> 접근 방법 수), 
- x 축은 입력 데이터프레임의 해당 피처를 나타냅니다.


Markdown Cell 29:
- We can note that for a lot of features, a small value in <code>correlation</code> magnitude (Pearson's value) also gives small score values in other approaches. Similarly high <code>correlated</code> features tend to have high scores in other <code>feature importance</code> methods, which is quite interesting. There are some exceptions, like <code>%D10</code> & <code>MOM10</code>
- Whilst there are a few features which show some slight dissagreement when it comes to feature importance, overall, <b>feature score similarity can be observed  for most approaches</b>
- It's interesting to note scores of identical feature cases (eg. <code>MOM10</code>, <code>MOM30</code>); we can get an idea of potentially new features that could we could try out ( perhaps <code>MOM20</code> would have worked better than <code>MOM10</code> )
- We can observe a lot of features that have a <b>very low relative score value</b> for most methods, and hence probably have little to no impact, even if they were to be removed
- Removing potentially unimpactful features (which is around 50% of them) would make our whole approach much more efficient, and allow us to focus on more lengthy and in depth <code>hyperparameter</code> gridsearches that hopefully will be more accurate than any of our current models

Markdown Cell 30:
대안적인 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">피처 축소</mark>** 방법은 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">비지도 학습</mark>** 방법을 사용하는 것입니다.
- 알고리즘을 선택해야 합니다 (여러 가지를 살펴보고 어떻게 수행되는지 확인하는 것이 가장 좋습니다),
- 어쩌면 일부 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">스케일링</mark>**을 적용하고 간단히 <code>fit_transform</code>을 적용하여 선택한 차원이 있는 수정된 <code>피처 행렬</code>을 얻을 수 있습니다.

다음 함수에는 다음을 선택할 수 있는 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">비지도 학습</mark>** 알고리즘이 포함되어 있습니다:
> - **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">PCA</mark>**, **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Sparse PCA</mark>**, **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Kernel PCA</mark>**, **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Incremental PCA</mark>**, **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Truncated SVD</mark>** 
> - **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Fast ICA</mark>**, **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Gaussian Random Projection</mark>**, **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Sparse Random Projection</mark>**
> - **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">IsoMap</mark>** (Manifold),**<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">MDS</mark>** (Manifold),**<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">TSNE</mark>** (Manifold)
> - **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Locally Linear Embedding</mark>**, **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Mini Batch Dictionary Learning</mark>**

- 모든 것이 제한된 계산 메모리 (특히 <b>Manifold</b> 접근 방식)으로 인해 캐글에서 실행되지 않을 수 있습니다. 특히 <code>red_mem</code> 함수가 활성화된 경우에도
- **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">manifold</mark>** 방법을 사용하기 전에 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">PCA</mark>** 단계 등 다단계 접근 방식을 사용하는 것은 너무 uncommon하지 않습니다.
- 여기에서는 계산 리소스를 적게 사용하는 방식을 사용할 것입니다.


Markdown Cell 31:
<code>df_tr2</code>에 <code>dimensionality reduction</code>을 사용한 후에 이전과 같은 방식으로 <code>modelEval</code> 함수를 사용하여 정확도 및 실행 시간을 확인합니다.
차원 축소에는 여기에서 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">Fast ICA</mark>**를 사용하며 다양한 데이터 **<mark style="background-color:#CDE10F;color:white;border-radius:5px;opacity:0.9">스케일링 방법</mark>**과 함께 다양한 조합을 시도할 수 있습니다. 최대한 높은 정확도를 얻는 것이 목표입니다.
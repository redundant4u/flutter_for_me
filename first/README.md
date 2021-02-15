# Changelog

## 201230
- L, R 별로 페이지들을 따로 만들고 독립적으로 나눔.
- [audioplayers](https://pub.dev/packages/audioplayers) 이용하여 간단한 player기를 만듬. ~~FirstPage에 있는 노래는 다음과 같다.~~

## 201231
- ThirdPage에 L, R 별로 DB 데이터 저장 및 출력 페이지 구성.

## 210105
- [charts_flutter](https://pub.dev/packages/charts_flutter)을 이용하여 그래프 페이지 구성(FourthPage).
- 그래프 점을 누르면 Tooltip 같은 정보 표시.
- 페이지별로 title이 변하도록 설정.
- ~~[volume_control](https://pub.dev/packages/volume_control)을 이용하여 SecondPage에 간단하게 volume 조절하는 함수 구현.~~

## 210106
- FirstPage는 TabBar 없이 구성하기 위해 Page에 있는 내용들을 수정함.
- ~~[flutter_xlider](https://pub.dev/packages/flutter_xlider)를 이용하여 SecondPage에 slider를 만들어 놓음. 기존에 있던 volume 조절 함수는 삭제.~~
- 백그라운드 색깔을 white로 통일. appbar, body, bottomNavigationBar 경계 제거.

## 210108
- [flutter_blue](https://pub.dev/packages/flutter_blue)를 이용하여 FirstPage에 간단한 블루투스 기기들의 스캔과 연결하는 페이지 구성.
- ~~'''Unhandled Expection: setState() called after dispose()''' 오류가 나서 추후에 조치 필요.~~

## 210113
- [circular_countdown_timer](https://pub.dev/packages/circular_countdown_timer)를 활용하여 FirstPage에 검사페이지 구성. 검사 후 해당 데이터 로컬DB에 저장.
- ThirdPage에 검사한 데이터를 최신 날짜별로 ListTile 형태로 출력. 해당 날짜를 탭하면 해당 데이터가 그래프 형식으로 출력.

## 210118
- [noise_meter](https://pub.dev/packages/noise_meter)를 이용하여 소음 측정을 FourthPage에 임시적으로 구현.

## 210119
- FirstPage, NoiseDetectorPage, FindBluetoothPage를 통합. 검사 조건을 만족해야 FirstPage의 검사를 할 수 있도록 설정.
- FirstPage 왼쪽 검사로 넘어갈 때의 setState() 문제 해결.
- 모바일의 크기에 따라 폰트 크기 및 길이가 변할 수 있도록 MediaQuery.dart 생성하여 관리.

## 210121
- SecondPage에 있던 flutter_xlider 패키지를 삭제하고 slider class로 대체하여 구현.
- SecondPage 오른쪽, 왼쪽 slider를 통해 값 변경을 DB에 저장하여 보관.
- FourthPage에 간단한 환경설정 틀 생성.

## 210122
- FirstPage 코드 수정. 변수명, 함수명, 로직 순서 수정. ~~최대한 깔끔하게 짜려 노력했지만 부족ㅠㅠ~~

## 210127
- ThirdPage의 그래프 부분을 dB 값 범위에 따라 색깔로 나누어서 시각적으로 표현.
- dB 자릿수 값마다 달라짐에 따라 width 값 조절하는 함수 추가.

## 210128
- FirstPage에서 검사 할 시 임의로 연속적으로 버튼을 누를경우 timer가 cancel이 안되는 오류 수정.

## 210205
- 개인정보를 보고 수정하는 페이지 구현. DB 파일 내용을 목적에 따라 모듈화 진행.

## 210215
- StartPage 추가(추후 삭제 고려).
- SecondPage의 EQ widget 부분을 for문을 활용하여 코드 수를 대폭 줄임.
- SecondPage의 EQ 페이지를 graphs table 값과 연동하여 EQ 값이 적절한 지 시각적으로 표현.
- users table의 bitrh column을 year, month, day로 쪼갬.
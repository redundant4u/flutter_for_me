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
- [flutter_xlider](https://pub.dev/packages/flutter_xlider)를 이용하여 SecondPage에 slider를 만들어 놓음. 기존에 있던 volume 조절 함수는 삭제.
- 백그라운드 색깔을 white로 통일. appbar, body, bottomNavigationBar 경계 제거.

## 210108
- [flutter_blue](https://pub.dev/packages/flutter_blue)를 이용하여 FirstPage에 간단한 블루투스 기기들의 스캔과 연결하는 페이지 구성.
- '''Unhandled Expection: setState() called after dispose()''' 오류가 나서 추후에 조치 필요.

## 210113
- [circular_countdown_timer](https://pub.dev/packages/circular_countdown_timer)를 활용하여 FirstPage에 검사페이지 구성. 검사 후 해당 데이터 로컬DB에 저장.
- ThirdPage에 검사한 데이터를 최신 날짜별로 ListTile 형태로 출력. 해당 날짜를 탭하면 해당 데이터가 그래프 형식으로 출력.
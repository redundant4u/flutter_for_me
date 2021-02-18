import 'package:flutter/material.dart';

import '../../db/EQ.dart';
import '../../db/Graph.dart';
import '../../utils/MediaQuery.dart';
import '../../utils/GetEQColor.dart';

class ThirdLeftPage extends StatefulWidget {
  @override
  ThirdLeftPageState createState() => new ThirdLeftPageState();
}

class ThirdLeftPageState extends State<ThirdLeftPage> with AutomaticKeepAliveClientMixin<ThirdLeftPage> {
  @override
  bool get wantKeepAlive => true;

  // leftEQ: futurebuilder의 future에 바로 getLeftEQData를 넣을 경우 값 변화가 안되므로 
  // 값을 한 번만 로딩하기 위해 future 변수를 만듬.
  List<double> _sliderValue = [], _leftGraphData = [];
  List<IconData> _eqIcons = List.filled(7, null);
  List<Color> _eqColors = List.filled(7, null);
  String warningMessage = "";

  Future _leftEQ;

  @override
  void initState() {
    super.initState();
    _leftEQ = getLeftEQData();
    _setEQState();
  }

  void _setEQState() async {
    _leftGraphData = await getLeftGraphData();
    if( _leftGraphData.length == 0 ) {
      warningMessage = "검사를 먼저 진행해주세요";
      return;
    }

    List<double> _tmpLeftEQ = await getLeftEQData();
    List tmp = await getEQIcons(_tmpLeftEQ, _leftGraphData);
    _eqIcons  = tmp[0];
    _eqColors = tmp[1];

    if( this.mounted ) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final double _mediaHeight = MediaQuery.of(context).size.height;
    final List<double> _mediaHeightList = getThirdPageHeight(_mediaHeight);
    final List<int> _widgetLoop = [ 0, 1, 2, 3, 4, 5, 6 ];
    final List<String> _widgetText = [ "125", "250", "500", "1K", "2K", "4K", "8K" ];

    return FutureBuilder<List<double>>(
      future: _leftEQ,
      builder: (context, snapshot) {
        if( snapshot.hasData && _leftGraphData.isNotEmpty ) {
          _sliderValue = snapshot.data;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for( int i in _widgetLoop )
              Column(
                children: <Widget>[
                  Container(
                    height: _mediaHeightList[0],
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _sliderValue[i],
                        max: 500,
                        min: 0,
                        divisions: 500,
                        label: _sliderValue[i].toString(),
                        onChanged: (double value) { _setSliderValue(value, i); },
                        onChangeEnd: (double value) async {
                          await upsertLeftEQData(_sliderValue);
                          _setEQState();
                        },
                      ),
                    ),
                  ),

                  Text(_widgetText[i]),

                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      _eqIcons[i],
                      color: _eqColors[i],
                      size: 30.0
                    )
                  )
                ],
              ),
            ],
          );
        }

        else return Text(warningMessage);
      }
    );
  }

  void _setSliderValue(double value, int index) {
    // tap으로 값 변화 방지 && 스크롤 속도 조절
    if( (_sliderValue[index] - value).abs() < 50 ) {
      setState( () { _sliderValue[index] = value; });
    }
  }
}
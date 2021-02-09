import 'package:flutter/material.dart';

import '../../db/EQ.dart';
import '../../db/Graph.dart';
import '../../utils/MediaQuery.dart';
import '../../utils/GetEQColor.dart';

class SecondLeftPage extends StatefulWidget {
  @override
  SecondLeftPageState createState() => new SecondLeftPageState();
}

class SecondLeftPageState extends State<SecondLeftPage> with AutomaticKeepAliveClientMixin<SecondLeftPage> {
  @override
  bool get wantKeepAlive => true;

  // leftEQ: futurebuilder의 future에 바로 getLeftEQData를 넣을 경우 값 변화가 안되므로 
  // 값을 한 번만 로딩하기 위해 future 변수를 만듬.
  List<double> _sliderValue = [];
  List<IconData> _eqIcons = [];
  List<Color> _eqColors = [];

  Future _leftEQ;

  @override
  void initState() {
    super.initState();
    _leftEQ = getLeftEQData();
    _setEQState();
  }

  void _setEQState() async {
    List<double> _leftGraphData = await getLeftGraphData();
    List<double> _tmpLeftEQ = await getLeftEQData();

    List tmp = await getEQIcons(_tmpLeftEQ, _leftGraphData);
    _eqIcons  = tmp[0];
    _eqColors = tmp[1];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final double _mediaHeight = MediaQuery.of(context).size.height;
    final List<double> _mediaHeightList = getSencondPageHeight(_mediaHeight);

    return FutureBuilder<List<double>>(
      future: _leftEQ,
      builder: (context, snapshot) {
        if( snapshot.hasData ) {
          _sliderValue = snapshot.data;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: _mediaHeightList[0],
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _sliderValue[0],
                        max: 500,
                        min: 0,
                        divisions: 500,
                        label: _sliderValue[0].toString(),
                        onChanged: (double value) { _setSliderValue(value, 0); },
                        onChangeEnd: (double value) async {
                          await upsertLeftEQData(_sliderValue);
                          _setEQState();
                        },
                      ),
                    ),
                  ),

                  Text('125'),

                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      _eqIcons[0],
                      color: _eqColors[0],
                      size: 30.0
                    )
                  )
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    height: _mediaHeightList[0],
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _sliderValue[1],
                        max: 500,
                        min: 0,
                        divisions: 500,
                        label: _sliderValue[1].toString(),
                        onChanged: (double value) { _setSliderValue(value, 1); },
                        onChangeEnd: (double value) async {
                          await upsertLeftEQData(_sliderValue);
                          _setEQState();
                        },
                      ),
                    ),
                  ),

                  Text('250'),

                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      _eqIcons[1],
                      color: _eqColors[1],
                      size: 30.0
                    ),
                  )
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    height: _mediaHeightList[0],
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _sliderValue[2],
                        max: 500,
                        min: 0,
                        divisions: 500,
                        label: _sliderValue[2].toString(),
                        onChanged: (double value) { _setSliderValue(value, 2); },
                        onChangeEnd: (double value) async {
                          await upsertLeftEQData(_sliderValue);
                          _setEQState();
                        },
                      ),
                    ),
                  ),

                  Text('500'),

                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      _eqIcons[2],
                      color: _eqColors[2],
                      size: 30.0
                    )
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    height: _mediaHeightList[0],
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _sliderValue[3],
                        max: 500,
                        min: 0,
                        divisions: 500,
                        label: _sliderValue[3].toString(),
                        onChanged: (double value) { _setSliderValue(value, 3); },
                        onChangeEnd: (double value) async {
                          await upsertLeftEQData(_sliderValue);
                          _setEQState();
                        },
                      ),
                    ),
                  ),

                  Text('1K'),

                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      _eqIcons[3],
                      color: _eqColors[3],
                      size: 30.0
                    )
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    height: _mediaHeightList[0],
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _sliderValue[4],
                        max: 500,
                        min: 0,
                        divisions: 500,
                        label: _sliderValue[4].toString(),
                        onChanged: (double value) { _setSliderValue(value, 4); },
                        onChangeEnd: (double value) async {
                          await upsertLeftEQData(_sliderValue);
                          _setEQState();
                        },
                      ),
                    ),
                  ),

                  Text('2K'),

                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      _eqIcons[4],
                      color: _eqColors[4],
                      size: 30.0
                    )
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    height: _mediaHeightList[0],
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _sliderValue[5],
                        max: 500,
                        min: 0,
                        divisions: 500,
                        label: _sliderValue[5].toString(),
                        onChanged: (double value) { _setSliderValue(value, 5); },
                        onChangeEnd: (double value) async {
                          await upsertLeftEQData(_sliderValue);
                          _setEQState();
                        },
                      ),
                    ),
                  ),

                  Text('4K'),

                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      _eqIcons[5],
                      color: _eqColors[5],
                      size: 30.0
                    )
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    height: _mediaHeightList[0],
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _sliderValue[6],
                        max: 500,
                        min: 0,
                        divisions: 500,
                        label: _sliderValue[6].toString(),
                        onChanged:   (double value) { _setSliderValue(value, 6); },
                        onChangeEnd: (double value) async {
                          await upsertLeftEQData(_sliderValue);
                          _setEQState();
                        },
                      ),
                    ),
                  ),

                  Text('8K'),

                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      _eqIcons[6],
                      color: _eqColors[6],
                      size: 30.0
                    )
                  ),
                ],
              ),

            ],
          );
        }

        else return Text('');
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
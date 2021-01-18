import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:ui';
import 'dart:math';

import '../TabBarPage.dart';

class NoiseDetector extends StatefulWidget {
  NoiseDetector();

  @override
  NoiseDetectorState createState() => new NoiseDetectorState();
}

class NoiseDetectorState extends State<NoiseDetector> {
  int _currentdB = 0; // 표시 데시벨
  String _isTestValidMsg = '테스트에 부적합한 장소입니다'; // 소음 확인 메세지의 텍스트
  Color _isTestValidColor = Colors.red; // 소음 확인 메세지의 색

  double _circleImageHeight;
  double _cautionImageHeight;
  double _buttonPadding;

  bool _isTestValid = true;
  bool _isRecording = false;

  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;

  @override
  void initState() {
    super.initState();
    setState(() {
      if( _currentdB < 60 ) _isTestValidMsg = '테스트에 적합한 장소입니다';
      else _isTestValidMsg = '테스트에 부적합한 장소입니다';
    });

    _noiseMeter = NoiseMeter(onError);

    startNoiseDectector();
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if( !_isRecording ) _isRecording = true;

      _currentdB = noiseReading.maxDecibel.toInt();

      if( _currentdB < 60 ) {
        _isTestValidMsg = '테스트에 적합한 장소입니다';
        _isTestValidColor = Color(0xff77B28F);
        _isTestValid = true;
      }
      
      else {
        _isTestValidMsg = '테스트에 부적합한 장소입니다';
        _isTestValidColor = Colors.red;
        _isTestValid = false;
      }
    });
  }

  void onError(PlatformException e) { print(e.toString()); _isRecording = false; }

  void startNoiseDectector() {
    try { _noiseSubscription = _noiseMeter.noiseStream.listen(onData); }
    catch (e) { print(e);}
  }

  void stopNoiseDectector() {
    _noiseSubscription?.cancel();
    _noiseSubscription = null;
    _isRecording = false;
  }

  @override
  void dispose() {
    super.dispose();
    stopNoiseDectector();
  }

  @override
  Widget build(BuildContext context) {
    if( MediaQuery.of(context).size.height > 700 ) {
      _circleImageHeight = 270.0;
      _cautionImageHeight = 140.0;
      _buttonPadding = 100.0;
    }

    else {
      _circleImageHeight = 230.0;
      _cautionImageHeight = 65.0;
      _buttonPadding = 10.0;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('소음 측정', style: TextStyle(color: Colors.black))
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '소음이 적은 장소로 \n이동하세요',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width / 10,
              height: _cautionImageHeight,
              child: Image.asset('assets/images/caution.png')
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: _circleImageHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/noise_circle.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: CustomPaint(
                        size: Size(150, 150),
                        foregroundPainter: MyPainter(_currentdB),
                        child: Container(
                          // padding: const EdgeInsets.only(top: 100),
                          width: 0,
                          height: _circleImageHeight,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                '$_currentdB db',
                style: TextStyle(
                  color: Color(0xff77B28F),
                  fontWeight: FontWeight.w100,
                  fontSize: 20,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 30),
              child: Text(
                _isTestValidMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _isTestValidColor,
                  fontWeight: FontWeight.w100,
                  fontSize: 20,
                )
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: _buttonPadding),
              child: MaterialButton(
                child: Text(
                  '계속하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  )
                ),
                color: _isTestValidColor,
                minWidth: MediaQuery.of(context).size.width / 1.3,
                height: 50,
                onPressed:() {
                  if( _isTestValid ) {
                    Navigator.pop(context); Navigator.pop(context);
                    Navigator.push( context, MaterialPageRoute(builder: (context) => TabBarPage()) );
                  }
                  else print('no');
                }
              ),
            )
          ]
        )
      )
    );
  }
}

class MyPainter extends CustomPainter {
  final int _currentdB;

  MyPainter(this._currentdB);

  @override
  void paint(Canvas canvas, Size size) {
    final points = [Offset(size.width / 2, size.height / 1.8)];

    Paint dot = Paint() // 중앙점 정보
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30.0;

    Paint bar = Paint() // 막대기 정보
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    Offset p1 = Offset(size.width / 2, size.height / 1.8); // 막대기
    Offset p2 = Offset(
      (-90 * sin(2 * _currentdB / 180 * pi) + size.width  / 2),
      (90  * cos(2 * _currentdB / 180 * pi) + size.height / 2)
    );

    canvas.drawLine(p1, p2, bar); // 선을 그림.
    canvas.drawPoints(PointMode.points, points, dot);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) { return false; }
}
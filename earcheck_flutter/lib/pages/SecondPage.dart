import 'package:flutter/material.dart';
import 'package:volume_control/volume_control.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import '../db/Graph.dart';
import './navigator/TestConditionCheckPage.dart';
import '../utils/MediaQuery.dart';

class SecondPage extends StatefulWidget {
  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  // _freqLevel: 음원 주파수 단계(총 6단계) _currentFreq: 현재 주파수 크기(125~8000)
  // _time: 타이머가 돌고있는 시간, 주파수가 언제 들리는지 확인하기 위한 변수
  // _timerStrokeWidth: 검사 시작하기 전 타이머가 돌 때 움직이는 모션을 숨기기 위한 변수
  int _freqLevel = 1, _currentFreq = 125;
  double _time = 0.0, _timerStrokeWidth = 0.0;
  String _earDirection = "오른쪽 귀", _button = "검사 환경\n확인하기";
  bool _firstPlay = false, _rightFlag = true, _checkCondition = false, _preventMultipleClick = false;
  IconData _playIcon = Icons.play_arrow_outlined;

  List<double> _dBLeftData = [];
  List<double> _dBRightData = [];

  Timer _timer;
  CountDownController _controller = CountDownController();
  AudioPlayer _player = AudioPlayer();
  AudioCache _cache = AudioCache();

  // timer setState 오류를 위해 dispose
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _player?.stop();
  }

  Widget build(BuildContext context) {
    final double _mediaHeight = MediaQuery.of(context).size.height;
    final List<double> _mediaHeightList = getSecondPageMediaHeight(_mediaHeight);
    final List<double> _fontSizeList = getSecondPageFontSize(_mediaHeight);

    return Center(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _earDirection,
                        style: TextStyle(color: Colors.black, fontSize: _fontSizeList[0]),
                      ),

                      Text(
                        "7단계 중 $_freqLevel단계",
                        style: TextStyle(color: Color(0xff77B28F), fontSize: _fontSizeList[0]),
                      )
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("freq: $_currentFreq"),
                      Text("time: $_time"),
                    ],
                  ),

                  IconButton(
                    icon: Icon(_playIcon),
                    iconSize: 40,
                    onPressed: () { setState(() { _timer?.cancel(); }); },
                  ),
                ],
              ),
            ],
          ),

          Stack(
            children: <Widget>[
              Positioned(
                child: CircularCountDownTimer(
                  duration: 10,
                  controller: _controller,
                  width: MediaQuery.of(context).size.width / 2 + 20,
                  height: _mediaHeightList[0],
                  color: Colors.transparent,
                  fillColor: Color(0xff77B28F),
                  backgroundColor: null,
                  strokeWidth: _timerStrokeWidth,
                  strokeCap: StrokeCap.butt,
                  isReverse: false,
                  isReverseAnimation: true,
                  isTimerTextShown: false,
                  onComplete: () {
                    _timer?.cancel();
                    _playIcon = Icons.play_arrow_outlined;
                    // setState(() { _playIcon = Icons.play_arrow_outlined; });
                  },
                ),
              ),

              Positioned(
                width: MediaQuery.of(context).size.width / 2 + 20,
                height: _mediaHeightList[0],
                child: MaterialButton(
                  shape: CircleBorder(
                    side: BorderSide(
                      width: 0,
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  color: Colors.white,
                  child: Container(
                    child: Text(
                      _button,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff77B28F),
                        fontWeight: FontWeight.w100,
                        fontSize: _fontSizeList[1],
                      ),
                    )
                  ),
                  onPressed: () async {
                    // 검사를 위한 블루투스 기기 및 소음 확인
                    if     ( !_checkCondition ) _checkTestCondition();
                    else if( _isTestEnded()   ) _savedBData();
                    else                        _earCheck();
                  },
                ),
              ),
            ],
          ),

          Text("작은 소리라도 들리면 \n중앙부를 터치하세요", style: TextStyle(color: Colors.red, fontSize: 15)),
        ],
      ),
    );
  }

  bool _isTestEnded() {
    if( _dBLeftData.length >= 6 ) return true;
    else                          return false;
  }

  void _savedBData() async {
    // 사용자가 검사 끝난 후 버튼 계속 누르는것을 방지하기 위해
    if( _button != "수고\n하셨습니다" ) {
      _dBLeftData.add(_time); // 마지막 데이터 추가
      _controller?.pause(); _timer?.cancel(); _player?.stop();
      _timerStrokeWidth = 0.0; _button = "수고\n하셨습니다";

      await insertLeftGraphData(_dBLeftData);
      await insertRightGraphData(_dBRightData);

      setState(() {});
    }
  }

  void _earCheck() {
    if( !_preventMultipleClick ) {
      _preventMultipleClick = true;

      VolumeControl.setVolume(0); _controller?.restart(); _player?.stop();

      // 첫 시작일 경우
      if( !_firstPlay ) _init();
      else {
        _checkEarDirection();
        _insertdBData();
      }

      _selectAudioFileAndPlay();
      _time = 0; // initalize to
    }
  }

  void _init() {
    _firstPlay = true;
    _playIcon = Icons.pause;
    _timerStrokeWidth = 30.0;
    _button = 'touch';
  }

  void _checkEarDirection() {
    // 오른쪽 -> 왼쪽 검사
    if( _freqLevel == 7 ) {
      _currentFreq = 125;
      _freqLevel = 1;
      _rightFlag = false;
      _earDirection = "왼쪽 귀";
    }
    else {
      _freqLevel++;
      _currentFreq *= 2;
    }
  }

  void _selectAudioFileAndPlay() async {
    String audioFile;

    // 왼쪽 마지막 클릭 시 _currentFreq가 16000가 되는 걸 방지
    if( _currentFreq > 8000 ) _currentFreq = 8000;
    if(_rightFlag) audioFile = "audio/${_currentFreq}L.wav";
    else           audioFile = "audio/${_currentFreq}R.wav";

    _player?.stop();
    _player = await _cache.play(audioFile);

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() { if(this.mounted) _time++; });
    });

    _preventMultipleClick = false;
  }

  void _insertdBData() {
    // 걸린 시간을 _freqData에 추가
    if( _dBRightData.length < 7 ) _dBRightData.add(_time);
    else                          _dBLeftData.add(_time);
  }

  void _checkTestCondition() async {
    _checkCondition = await Navigator.push( context, MaterialPageRoute(builder: (context) => TestConditionCheckPage()) );
    // 사용자가 TestConditionCheckPage에서 뒤로가기를 누른 경우 방지
    if( _checkCondition == null ) _checkCondition = false;
    else if( _checkCondition ) {
      setState(() { _button = "준비가 끝나면 \n 눌러주세요"; });
    }
  }
}

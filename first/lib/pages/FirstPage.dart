import 'package:flutter/material.dart';
import 'package:volume_control/volume_control.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import 'dart:async';

import '../db/db.dart';

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  // _freqLevel: 음원 주파수 단계(총 6단계) _currentFreq: 현재 주파수 크기(250~16000)
  // _time: 타이머가 돌고있는 시간, 주파수가 언제 들리는지 확인하기 위한 변수
  // _dbData: 측정 데이터(db) _timerStrokeWidth: 검사 시작하기 전 타이머가 돌 때 움직이는 모션을 숨기기 위한 변수
  int _freqLevel = 1, _currentFreq = 250, _time = 0;
  double _timerStrokeWidth = 0.0, _mobilePadding;
  String _earDirection = "오른쪽 귀", _button = "준비가 끝나면 \n 눌러주세요";
  bool _isStart = false, _rightFlag = true;
  IconData _playIcon = Icons.play_arrow_outlined;

  List<int> _dbLeftData = [];
  List<int> _dbRightData = [];

  Timer _timer;
  CountDownController _controller = CountDownController();
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();

  // timer setState 오류를 위해 dispose
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    player?.stop();
  }

  Widget build(BuildContext context) {
    if( MediaQuery.of(context).size.height > 700 ) _mobilePadding = 563.0;
    else _mobilePadding = 383.0;

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
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),

                      Text(
                        "7단계 중 $_freqLevel단계",
                        style: TextStyle(color: Color(0xff77B28F), fontSize: 20),
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
                  height: _mobilePadding,
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
                height: _mobilePadding,
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
                        fontSize: 30,
                      ),
                    )
                  ),
                  onPressed: () async {
                    // 오른쪽, 왼쪽 검사 후 종료 안내
                    if( _dbLeftData.length == 6 && _isStart ) {
                      _dbLeftData.add(_time); // 마지막 데이터 추가
                      _controller?.pause(); _timer?.cancel(); player?.stop();
                      _isStart = false;  _timerStrokeWidth = 0.0; _button = "수고\n하셨습니다";

                      await DB.instance.insertLeftData(_dbLeftData);
                      await DB.instance.insertRightData(_dbRightData);
                      setState(() {});

                      return;
                    }

                    // 사용자가 검사 끝난 후 버튼 계속 누르는것을 방지하기 위해
                    else if( _dbLeftData.length == 7 && _isStart == false ) return;
                    else {
                      VolumeControl.setVolume(0); _controller?.restart(); player?.stop();
                      _playEarCheck();
                    }
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

  void _playEarCheck() {
    // 첫 시작일 경우 패스
    if( _isStart == false ) {
      _playIcon = Icons.pause; _timerStrokeWidth = 30.0; _button = 'touch'; _isStart = true; 
      setState(() {});
    }

    else {
      // 오른쪽 -> 왼쪽 검사
      if( _freqLevel == 7 ) { _currentFreq = 125; _freqLevel = 1; _rightFlag = false; _earDirection = "왼쪽 귀"; setState(() {}); }
      else _freqLevel++;

      // 걸린 시간을 _freqData에 추가
      if( _dbRightData.length < 7 ) _dbRightData.add(_time);
      else if( _dbLeftData.length == 7 ) return;
      else _dbLeftData.add(_time);
      _currentFreq *= 2;
    }

    _selectEarCheckFile();
  }

  void _selectEarCheckFile() async {
    String audioFile;

    _time = 0; // initalize to 0

    if(_rightFlag) audioFile = "audio/${_currentFreq}L.wav";
    else           audioFile = "audio/${_currentFreq}R.wav";

    player?.stop();
    player = await cache.play(audioFile);

    _timerStart();
  }

  void _timerStart() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() { if(this.mounted) _time++; });
    });
  }
}

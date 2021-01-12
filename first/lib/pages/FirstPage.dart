import 'package:flutter/material.dart';
import 'package:volume/volume.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import 'dart:async';

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  AudioManager audioManager;
  ShowVolumeUI showVolumeUI = ShowVolumeUI.SHOW;

  // _freqLevel: 음원 주파수 단계(총 6단계) _currentFreq: 현재 주파수 크기(250~16000)
  // _time: 타이머가 돌고있는 시간, 주파수가 언제 들리는지 확인하기 위한 변수 _timeCycle: 10초 다 되면 1로 바뀜(확인용)
  // _freqData: ... _timerStrokeWidth: 검사 시작하기 전 타이머가 돌 때 움직이는 모션을 숨기기 위한 변수
  int _freqLevel = 0, _currentFreq = 250, _time = 0, _timeCycle = 0, _freqData = 0;
  double _timerStrokeWidth = 0.0;
  String _earDirection = "왼쪽 귀", _button = "준비가 끝나면 \n 눌러주세요";
  bool _isStart = true, _leftFlag = true;
  IconData _playIcon = Icons.play_arrow_outlined;

  Timer _timer;
  CountDownController _controller = CountDownController();
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();

  @override
  void initState() {
    super.initState();

    _timer?.cancel();
    audioManager = AudioManager.STREAM_MUSIC; // Controll media volume
    initAudioStreamType();
  }

  Future<void> initAudioStreamType() async { await Volume.controlVolume(audioManager); }
  Future<void> setVol(int i) async { await Volume.setVol(i, showVolumeUI: showVolumeUI); }

  Widget build(BuildContext context) {
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
                        "6단계 중 $_freqLevel단계",
                        style: TextStyle(color: Color(0xff77B28F), fontSize: 15),
                      )
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("freq: $_currentFreq"),
                      Text("time: $_time"),
                      Text("timecycle: $_timeCycle"),
                      Text("freqdata: $_freqData"),
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
                  height: MediaQuery.of(context).size.height / 2 + 30,
                  color: Colors.transparent,
                  fillColor: Color(0xff77B28F),
                  backgroundColor: null,
                  strokeWidth: _timerStrokeWidth,
                  strokeCap: StrokeCap.butt,
                  isReverse: false,
                  isReverseAnimation: true,
                  isTimerTextShown: false,
                  onComplete: () {
                    _timeCycle = 1;
                    _timer?.cancel();
                    _playIcon = Icons.play_arrow_outlined;
                    // setState(() { _playIcon = Icons.play_arrow_outlined; });
                  },
                ),
              ),

              Positioned(
                width: MediaQuery.of(context).size.width / 2 + 20,
                height: MediaQuery.of(context).size.height / 2 + 30,
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
                  onPressed: () {
                    if( _freqLevel >= 6 ) {
                      print('7단계!!!'); player?.stop(); _controller.pause(); _timer?.cancel();
                      return;
                    }

                    // 첫 시작일 때 값 설정
                    if( _isStart ) {
                      print('first start!!!');
                      _playIcon = Icons.pause; _isStart = false; _timerStrokeWidth = 30.0; _button = 'touch';
                      setState(() {});
                    }

                    setVol(0); _controller.restart(); player?.stop();
                    _playEarCheck();
                  },
                ),
              ),
            ],
          ),

          Text("작은 소리라도 들리면 \n 중앙부를 터치하세요", style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  void _playEarCheck() {
    if( _currentFreq < 16000 ) _freqLevel++;
    else if(_leftFlag) { _freqLevel = 1; _leftFlag = false; _earDirection = "오른쪽 귀"; }
    else               { _freqLevel = 1; _leftFlag = true;  _earDirection = "왼쪽 귀"; }

    // 걸린 시간이 _freqData
    _freqData = _time;
    _currentFreq *= 2;

    if( _freqData > 8000 ) _freqData = 8000;

    _selectEarCheckFile();
  }

  void _selectEarCheckFile() async {
    String audioFile;

    _timeCycle = 0;
    _time = 0; // initalize to 0

    if(_leftFlag) audioFile = "audio/${_currentFreq}L.wav";
    else          audioFile = "audio/${_currentFreq}R.wav";

    player?.stop();
    player = await cache.play(audioFile);

    _timerStart();
  }

  void _timerStart() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() { if(this.mounted) _time++; });
    });
  }
}

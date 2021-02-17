import 'package:flutter/material.dart';

import '../utils/ShowPage.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  String _title = "시작페이지";
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(_title, style: TextStyle(color: Colors.black),),
      ),

      body: showPage(_index),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        currentIndex: _index,
        onTap: (int _index) {
          setState(() {
            this._index = _index;

            switch(_index) {
              case 0: _title = "시작 페이지"; break;
              case 1: _title = "검사"; break;
              case 2: _title = "EQ"; break;
              case 3: _title = "그래프 기록"; break;
              case 4: _title = "환경설정"; break;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey, size: 43),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/first.png', width: 35),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/second.png', width: 40),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/third.png', width: 23),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/fourth.png', width: 35),
            label: ''
          ),
        ],
      ),
    );
  }
}
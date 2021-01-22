import 'package:flutter/material.dart';

import './FirstPage.dart';
import './SecondPage.dart';
import './ThirdPage.dart';
import './FourthPage.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { return MainWidget(); }
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  String _title = "검사";
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

      body: _showPage(_index),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        currentIndex: _index,
        onTap: (int _index) {
          setState(() {
            this._index = _index;

            switch(_index) {
              case 0: _title = "검사"; break;
              case 1: _title = "EQ"; break;
              case 2: _title = "그래프 기록"; break;
              case 3: _title = "환경설정"; break;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
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

Widget _showPage(int i) {
  Widget res;

  switch(i) {
    case 0: res = FirstPage();  break;
    case 1: res = SecondPage(); break;
    case 2: res = ThirdPage();  break;
    case 3: res = FourthPage(); break;
  }
  
  return res;
}
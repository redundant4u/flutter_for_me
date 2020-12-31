import 'package:flutter/material.dart';

import './left/FirstLeftPage.dart';
import './left/SecondLeftPage.dart';
import './left/ThirdLeftPage.dart';
import './right/FirstRightPage.dart';
import './right/SecondRightPage.dart';
import './right/ThirdRightPage.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainWidget()
    );
  }
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _index;

  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('First Demo'),
        bottom: TabBar(
          indicatorColor: Colors.black,
          labelStyle: TextStyle(fontSize: 20),
          unselectedLabelStyle: TextStyle(fontSize: 15),
          controller: _controller,
          tabs: <Tab>[
            Tab(text: 'L'),
            Tab(text: 'R'),
          ]),
      ),

      body: TabBarView(
        controller: _controller,
        children: [
          _leftPage(_index),
          _rightPage(_index),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int _index) {
          setState(() { this._index = _index; });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_home_screen, size: 40),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_on_rounded, size: 40),
            label: ''
          ),
        ],
      ),
    );
  }
}

Widget _leftPage(int i) {
  Widget res;

  switch(i) {
    case 0: res = FirstLeftPage();  break;
    case 1: res = SecondLeftPage(); break;
    case 2: res = ThirdLeftPage();  break;
  }

  return res;
}

Widget _rightPage(int i) {
  Widget res;

  switch(i) {
    case 0: res = FirstRightPage();  break;
    case 1: res = SecondRightPage(); break;
    case 2: res = ThirdRightPage();  break;
  }

  return res;
}
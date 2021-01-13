import 'package:flutter/material.dart';

import './left/ThirdLeftPage.dart';
import './right/ThirdRightPage.dart';

class ThirdGraphPage extends StatefulWidget {
  final int id;
  ThirdGraphPage(this.id);

  @override
  ThirdGraphPageState createState() => ThirdGraphPageState();
}

class ThirdGraphPageState extends State<ThirdGraphPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('그래프 보기', style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 20),
          controller: _controller,
          tabs: <Tab>[
            Tab(text: 'L'),
            Tab(text: 'R'),
          ],
        ),
      ),

      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          _leftPage(),
          _rightPage()
        ],
      ),
    );
  }


  Widget _leftPage()  { return ThirdLeftPage(widget.id);  }
  Widget _rightPage() { return ThirdRightPage(widget.id); }
}
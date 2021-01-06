import 'package:flutter/material.dart';

import './left/SecondLeftPage.dart';
import './right/SecondRightPage.dart';

class SecondPage extends StatefulWidget {
  @override
  SecondPageState createState() => new SecondPageState();
}

class SecondPageState extends State<SecondPage> with SingleTickerProviderStateMixin {
  TabController _controller;

  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          child: TabBar(
            indicatorColor: Colors.black,
            labelStyle: TextStyle(fontSize: 20),
            labelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontSize: 15),
            controller: _controller,
            tabs: <Tab>[
              Tab(text: 'L'),
              Tab(text: 'R'),
            ]),
        ),

        Expanded(
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              _leftPage(),
              _rightPage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _leftPage() { return SecondLeftPage(); }
  Widget _rightPage() { return SecondRightPage(); }
}
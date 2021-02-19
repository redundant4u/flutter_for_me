import 'package:flutter/material.dart';

import './left/ThirdLeftPage.dart';
import './right/ThirdRightPage.dart';

class ThirdPage extends StatefulWidget {
  @override
  ThirdPageState createState() => new ThirdPageState();
}

class ThirdPageState extends State<ThirdPage> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
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

  Widget _leftPage() { return ThirdLeftPage(); }
  Widget _rightPage() { return ThirdRightPage(); }
}
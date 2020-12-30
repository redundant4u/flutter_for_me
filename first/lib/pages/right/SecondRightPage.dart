import 'package:flutter/material.dart';

class SecondRightPage extends StatefulWidget {
  final int index;

  SecondRightPage(this.index);

  @override
 SecondRightPageState createState() => new SecondRightPageState();
}

class SecondRightPageState extends State<SecondRightPage> with AutomaticKeepAliveClientMixin<SecondRightPage> {
  @override
  bool get wantKeepAlive => true;

  int _count = 0;

  void _increment() { setState(() { _count++; }); }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Center(
        child: Text('Right $_count'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
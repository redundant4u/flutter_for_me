import 'package:flutter/material.dart';

class SecondLeftPage extends StatefulWidget {
  @override
  SecondLeftPageState createState() => new SecondLeftPageState();
}

class SecondLeftPageState extends State<SecondLeftPage> with AutomaticKeepAliveClientMixin<SecondLeftPage> {
  @override
  bool get wantKeepAlive => true;

  int _count = 0;

  void _increment() { setState(() { _count++; }); }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Center(
        child: Text('Left $_count'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
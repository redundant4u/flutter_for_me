import 'package:flutter/material.dart';
import 'package:volume_control/volume_control.dart';
import 'dart:async';

class SecondLeftPage extends StatefulWidget {
  @override
  SecondLeftPageState createState() => new SecondLeftPageState();
}

class SecondLeftPageState extends State<SecondLeftPage> with AutomaticKeepAliveClientMixin<SecondLeftPage> {
  @override
  bool get wantKeepAlive => true;

  int _count = 0;
  double _vol;

  void _increment() { setState(() { _count++; }); }
  void initState() {
    super.initState();
    initVolumeState();
  }

  Future<void> initVolumeState() async {
    if(!mounted) return;

    _vol = await VolumeControl.volume;
    print('current volume is $_vol');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Row(
        children: [
          Center(
            child: Text('Left $_count'),
          ),
          MaterialButton(
            child: Text('Set Volume'),
            onPressed: () {
              _vol = 0.5;
              setState(() {
                VolumeControl.setVolume(_vol);
              });

              print('current volume is $_vol');
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
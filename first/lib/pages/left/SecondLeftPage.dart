import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';


class SecondLeftPage extends StatefulWidget {
  @override
  SecondLeftPageState createState() => new SecondLeftPageState();
}

class SecondLeftPageState extends State<SecondLeftPage> {
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 400,
                child: FlutterSlider(
                  axis: Axis.vertical,
                  rtl: true,
                  values: [300],
                  max: 500,
                  min: 0,
                  selectByTap: false,
                ),
              ),
              Text('125')
            ],
          ),

          Column(
            children: <Widget>[
              Container(
                height: 400,
                child: FlutterSlider(
                  axis: Axis.vertical,
                  rtl: true,
                  values: [300],
                  max: 500,
                  min: 0,
                  selectByTap: false,
                ),
              ),
              Text('250')
            ],
          ),

          Column(
            children: <Widget>[
              Container(
                height: 400,
                child: FlutterSlider(
                  axis: Axis.vertical,
                  rtl: true,
                  values: [300],
                  max: 500,
                  min: 0,
                  selectByTap: false,
                ),
              ),
              Text('500')
            ],
          ),

          Column(
            children: <Widget>[
              Container(
                height: 400,
                child: FlutterSlider(
                  axis: Axis.vertical,
                  rtl: true,
                  values: [300],
                  max: 500,
                  min: 0,
                  selectByTap: false,
                ),
              ),
              Text('1K')
            ],
          ),

          Column(
            children: <Widget>[
              Container(
                height: 400,
                child: FlutterSlider(
                  axis: Axis.vertical,
                  rtl: true,
                  values: [300],
                  max: 500,
                  min: 0,
                  selectByTap: false,
                ),
              ),
              Text('2K')
            ],
          ),
        ],
      );
    // );
  }
}
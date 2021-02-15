import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  IconData icon1 = Icons.power, icon2 = Icons.power;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 100.0),
                    child: SizedBox(
                      width:MediaQuery.of(context).size.height / 4.5,
                      height: MediaQuery.of(context).size.height / 6,
                      child: Image.asset('assets/images/left.png')
                    )
                  ),

                  Container(
                    width:MediaQuery.of(context).size.height / 4.5,
                    height: MediaQuery.of(context).size.height / 6,
                    child: IconButton(
                      icon: Icon(icon1, size: 100.0),
                      onPressed: (() {
                        if( icon1 == Icons.power ) icon1 = Icons.power_off;
                        else                       icon1 = Icons.power;
                        setState(() {});
                      }),
                    )
                  )
                ]
              ),

              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 100.0),
                    child: SizedBox(
                      width:MediaQuery.of(context).size.height / 4.5,
                      height: MediaQuery.of(context).size.height / 6,
                      child: Image.asset('assets/images/right.png')
                    )
                  ),

                  Container(
                    width:MediaQuery.of(context).size.height / 4.5,
                    height: MediaQuery.of(context).size.height / 6,
                    child: IconButton(
                      icon: Icon(icon2, size: 100.0),
                      onPressed: (() {
                        if( icon2 == Icons.power ) icon2 = Icons.power_off;
                        else                       icon2 = Icons.power;
                        setState(() {});
                      }),
                    )
                  )
                ]
              )
            ]
          )
        ],
      )
    );
  }
}
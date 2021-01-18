import 'package:flutter/material.dart';

import './navigator/FindBluetoothPage.dart';
import './navigator/NoiseDetector.dart';

class FourthPage extends StatefulWidget {
  @override
  FourthPageState createState() => new FourthPageState();
}

// connetedDevice: FindBluetoothPage에서 기기를 찾고 그 값을 받는 int 변수. bool로 정의할 시
// null 값 때문에 int 값으로 설정.
class FourthPageState extends State<FourthPage> {
  final String connectMsg = "기기가 연결되지 않았습니다.";
  Color buttonColor = Colors.grey;
  int connectedDevice;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SizedBox(
              width:MediaQuery.of(context).size.height / 10,
              height: MediaQuery.of(context).size.height / 10,
              child: Image.asset('assets/images/caution.png')
            )
          ),

          Container(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(connectMsg),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/inear.png"),
                        fit: BoxFit.fill
                      )
                    ),
                  )
                ],
              ),
            ),
          ),

          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: MaterialButton(
                  height: 50,
                  child: Text('연결(임시)', style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                  minWidth: 250.0,
                  onPressed: () async {
                    connectedDevice = await Navigator.push( context, MaterialPageRoute(builder: (context) => FindBluetoothPage()) );
                    setState(() { if( connectedDevice == 1 ) buttonColor = Color(0xff77B28F); });
                  },
                ),
              ),

              Container(
                child: MaterialButton(
                  height: 50,
                  child: Text('다음', style: TextStyle(color: Colors.white)),
                  color: buttonColor,
                  minWidth: 250.0,
                  onPressed: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => NoiseDetector()) );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import './FindBluetoothPage.dart';
import './NoiseDetectorPage.dart';

class TestConditionCheckPage extends StatefulWidget {
  @override
  TestConditionCheckPageState createState() => new TestConditionCheckPageState();
}

// connetedDevice: FindBluetoothPage에서 기기를 찾고 그 값을 받는 int 변수. bool로 정의할 시
// null 값 때문에 int 값으로 설정.
class TestConditionCheckPageState extends State<TestConditionCheckPage> {
  final String connectMsg = "기기가 연결되지 않았습니다.";
  Color buttonColor = Colors.grey;
  bool _connectedDevice = false, _noiseCondition = false;

  @override
  Widget build(BuildContext context) {
    // 바로 Center로 적으면 이 페이지로 navigator push 할 시 검은 화면 바탕으로 뜨므로 Scaffold를 적어줘야 함.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('검사 환경 확인하기', style: TextStyle(color: Colors.black))
      ),
      body: Center(
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
                      _connectedDevice = await Navigator.push( context, MaterialPageRoute(builder: (context) => FindBluetoothPage()) );
                      // 사용자가 FindBluetoothPage에서 뒤로가기를 누른 경우 방지
                      if( _connectedDevice == null ) _connectedDevice = false;
                      setState(() { if( _connectedDevice ) buttonColor = Color(0xff77B28F); });
                    },
                  ),
                ),

                Container(
                  child: MaterialButton(
                    height: 50,
                    child: Text('다음', style: TextStyle(color: Colors.white)),
                    color: buttonColor,
                    minWidth: 250.0,
                    onPressed: () async {
                      _noiseCondition = await Navigator.push( context, MaterialPageRoute(builder: (context) => NoiseDetectorPage()) );
                      // 사용자가 NoiseDetectorPage에서 뒤로가기를 누른 경우 방지
                      if( _noiseCondition == null ) _noiseCondition = false;
                      if( _connectedDevice && _noiseCondition )  Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

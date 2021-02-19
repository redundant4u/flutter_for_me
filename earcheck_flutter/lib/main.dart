import 'package:flutter/material.dart';

import './db/User.dart';
import './pages/ControllerPage.dart';
import './pages/navigator/PrivacyInformation.dart';

void main() => runApp(new FirstApp());

class FirstApp extends StatefulWidget {
  @override
  _FirstAppState createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
  Widget _widget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: getPrivacyInformationData(),
        builder: (context, snapshot) {
          if( snapshot.hasData ) {
            if( snapshot.data.id != null )
              _widget = ControllerPage();
            else
              _widget = PrivacyInformation();

            return _widget;
          }

          else
            return Scaffold(
              body: Center(
                child: Text('로딩 중...')
              )
            );
        },
      )
    );
  }
}
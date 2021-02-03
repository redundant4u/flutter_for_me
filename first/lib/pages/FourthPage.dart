import 'package:flutter/material.dart';

import './left/FourthLeftPage.dart';
import './navigator/PrivacyInformation.dart';

class FourthPage extends StatelessWidget {
  final List<String> title = [ '개인정보 보기', 'EQ DB' ];

  @override
  Widget build(BuildContext context ) {
    return ListView.separated(
      padding: EdgeInsets.all(10.0),
      separatorBuilder: (context, index) => Divider(color: Color(0xFFF0AD74)),
      itemCount: title.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(title[index]),
          onTap: () {
            switch( index ) {
              case 0:
                Navigator.push( context, MaterialPageRoute(builder: (context) => PrivacyInformation()) );
                break;

              case 1:
                Navigator.push( context, MaterialPageRoute(builder: (context) => FourthLeftPage()) );
                break;
            }
          }
        );
      },
    );
  }
}
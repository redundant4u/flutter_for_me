import 'package:flutter/material.dart';

import './left/FourthLeftPage.dart';

class FourthPage extends StatelessWidget {
  final List<String> title = [ '회원가입', '로그인', 'EQ DB' ];

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
            if( index == 2 ) Navigator.push( context, MaterialPageRoute(builder: (context) => FourthLeftPage()) );
          }
        );
      },
    );
  }
}
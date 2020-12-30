import 'package:flutter/material.dart';

class ThirdRightPage extends StatelessWidget {
  final int index;

  ThirdRightPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('thirdpage: $index'),
    );
  }
}
import 'package:flutter/material.dart';

class ThirdLeftPage extends StatelessWidget {
  final int index;

  ThirdLeftPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('thirdpage: $index'),
    );
  }
}
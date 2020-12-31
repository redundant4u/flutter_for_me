import 'package:flutter/material.dart';
import './pages/TabBarPage.dart';

void main() => runApp(new FirstApp());

class FirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabBarPage()
    );
  }
}
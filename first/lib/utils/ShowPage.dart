import 'package:flutter/material.dart';

import '../pages/FirstPage.dart';
import '../pages/SecondPage.dart';
import '../pages/ThirdPage.dart';
import '../pages/FourthPage.dart';

Widget showPage(int i) {
  Widget res;

  switch(i) {
    case 0: res = FirstPage();  break;
    case 1: res = SecondPage(); break;
    case 2: res = ThirdPage();  break;
    case 3: res = FourthPage(); break;
  }
  
  return res;
}
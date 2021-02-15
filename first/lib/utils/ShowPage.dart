import 'package:flutter/material.dart';

import '../pages/StartPage.dart';
import '../pages/FirstPage.dart';
import '../pages/SecondPage.dart';
import '../pages/ThirdPage.dart';
import '../pages/FourthPage.dart';

Widget showPage(int i) {
  Widget res;

  switch(i) {
    case 0: res = StartPage();  break;
    case 1: res = FirstPage();  break;
    case 2: res = SecondPage(); break;
    case 3: res = ThirdPage();  break;
    case 4: res = FourthPage(); break;
  }
  
  return res;
}
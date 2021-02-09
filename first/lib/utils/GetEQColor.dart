import 'package:flutter/material.dart';

Future<List> getEQIcons(List<double> _eq, List<double> _dB) async {
  List<IconData> _eqIcons = [];
  List<Color> _eqColors = [];

  void good() {
    _eqIcons.add(Icons.check);
    _eqColors.add(Colors.green);
  }

  void warning() {
    _eqIcons.add(Icons.warning_amber_rounded);
    _eqColors.add(Colors.yellow);
  }

  void danger() {
    _eqIcons.add(Icons.dangerous);
    _eqColors.add(Colors.red);
  }

  for( int i = 0; i < _eq.length; i++ ) {
    if( _eq[i] < 100 ) {
      if     ( _dB[i] < 40 ) good();
      else if( _dB[i] < 80 ) warning();
      else                   danger();
    }

    else if( _eq[i] < 300 ) {
      if     ( _dB[i] < 40 ) warning();
      else if( _dB[i] < 80 ) good();
      else                   warning();
    }

    else {
      if     ( _dB[i] < 40 ) danger();
      else if( _dB[i] < 80 ) warning();
      else                   good();
    }
  }

  return [ _eqIcons, _eqColors ];
}
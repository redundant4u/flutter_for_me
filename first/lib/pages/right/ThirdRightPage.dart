import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ThirdRightPage extends StatelessWidget {
  final List<charts.Series<LinearSales, int>> seriesList = _createSampleData();
  final bool animate = false;

  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(5, 15),
      new LinearSales(10, 10),
      new LinearSales(13, 30),
    ];

    return [
      new charts.Series(
        id: 'Sales',
        data: data,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
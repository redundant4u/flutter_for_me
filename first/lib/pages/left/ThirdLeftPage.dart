import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// ignore: implementation_imports
import 'package:charts_flutter/src/text_element.dart' as chartText;
// ignore: implementation_imports
import 'package:charts_flutter/src/text_style.dart' as chartStyle;

import 'dart:math';

class ThirdLeftPage extends StatelessWidget {
  final List<charts.Series<LinearSales, int>> seriesList = _createSampleData();
  final bool animate = false;

  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: false),
      flipVerticalAxis: true,
      domainAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 9),
        tickFormatterSpec: dBTickFormatter,
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
        showAxisLine: true
        // tickFormatterSpec: hZTickFormatter,
      ),
      behaviors: [
        charts.LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer()),
        charts.ChartTitle(
          'dB',
          behaviorPosition: charts.BehaviorPosition.start,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
        ),
        charts.ChartTitle(
          'Hz',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
        ),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
          changedListener: (charts.SelectionModel model) {
            if(model.hasDatumSelection) {
              final value = model.selectedSeries[0].measureFn(model.selectedDatum[0].index).toString();
              CustomCircleSymbolRenderer.value = value;
            }
          }
        )
      ],
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(-20, -1),
      new LinearSales(null, -1),
      new LinearSales(50, 0),
      new LinearSales(55, 1),
      new LinearSales(60, 2),
      new LinearSales(30, 3),
      new LinearSales(40, 4),
      new LinearSales(70, 5),
      new LinearSales(65, 6),
      new LinearSales(null, -1),
      new LinearSales(160, 7),
    ];

    return [
      new charts.Series(
        id: 'Sales',
        data: data,
        domainFn: (LinearSales sales, _) => sales.hZ,
        measureFn: (LinearSales sales, _) => sales.dB
      )
    ];
  }

  final dBTickFormatter = charts.BasicNumericTickFormatterSpec((num i) {
    String res;

    switch(i) {
      case -1: res = ""; break;
      case 0: res = "125"; break;
      case 1: res = "250"; break;
      case 2: res = "500"; break;
      case 3: res = "1K"; break;
      case 4: res = "2K"; break;
      case 5: res = "4K"; break;
      case 6: res = "8K"; break;
      case 7: res = ""; break;
    }

    return res;
  });

  final hZTickFormatter = charts.BasicNumericTickFormatterSpec((num i) {
    String res;

    switch(i) {
      case -20: res = "125"; break;
      case 50: res = "250"; break;
      case 55: res = "500"; break;
      case 60: res = "1K"; break;
      case 30: res = "2K"; break;
      case 40: res = "4K"; break;
      case 70: res = "8K"; break;
    }

    return res;
  });
}

class LinearSales {
  final int dB;
  final int hZ;

  LinearSales(this.dB, this.hZ);
}

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  static String value;

  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
    {
      List<int> dashPattern,
      charts.Color fillColor,
      charts.FillPatternType fillPattern,
      charts.Color strokeColor,
      double strokeWidthPx
    }) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
      Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
      fill: charts.Color.fromHex(code: '#666666'),
    );
    var textStyle = chartStyle.TextStyle();
    textStyle.color = charts.Color.white;
    textStyle.fontSize = 15;
    canvas.drawText(
      chartText.TextElement("$value", style: textStyle), (bounds.left - 4.5).round(), (bounds.top - 28).round()
    );
  }
}
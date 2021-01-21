import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/text_element.dart' as chartText; // ignore: implementation_imports
import 'package:charts_flutter/src/text_style.dart' as chartStyle;  // ignore: implementation_imports

import 'dart:math';

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  static String value;

  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
    {
      List<int> dashPattern,
      Color fillColor,
      FillPatternType fillPattern,
      Color strokeColor,
      double strokeWidthPx
    }) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
      Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 11, bounds.height + 10),
      fill: Color.fromHex(code: '#666666'),
    );
    var textStyle = chartStyle.TextStyle();
    textStyle.color = Color.white;
    textStyle.fontSize = 15;
    canvas.drawText(
      chartText.TextElement("$value", style: textStyle), (bounds.left - 4.5).round(), (bounds.top - 28).round()
    );
  }
}
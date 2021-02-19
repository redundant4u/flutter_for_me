import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

import '../../db/Graph.dart';
import '../../models/Graph.dart';
import '../../utils/CustomCircleSymbolRenderer.dart';

class FourthRightPage extends StatefulWidget {
  final int id;
  FourthRightPage(this.id);

  @override
  FourthRightPageState createState() => FourthRightPageState();
}

class FourthRightPageState extends State<FourthRightPage> with AutomaticKeepAliveClientMixin {
  // tab 왔다갔다 할 시 자동 setstate 방지를 위함
  @override
  bool get wantKeepAlive => true;

  // seriesList: chart에 그릴 데이터 변수
  List<Series<Graph, int>> seriesList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<List<double>>(
      future: getRightGraphData(widget.id),
      builder: (context, snapshot) {
        // snapshot.hasData안 하면 The method '[]' was called on null 오류 발생
        if( snapshot.hasData ) {
          seriesList = _setChartData(snapshot.data);

          return LineChart(
            seriesList,
            animate: false,
            defaultRenderer: LineRendererConfig(includePoints: true),
            flipVerticalAxis: true,
            layoutConfig: LayoutConfig(
              topMarginSpec: MarginSpec.fixedPixel(30),
              rightMarginSpec: MarginSpec.fixedPixel(30),
              bottomMarginSpec: MarginSpec.fixedPixel(90),
              leftMarginSpec: MarginSpec.fixedPixel(50)
            ),
            domainAxis: NumericAxisSpec(
              tickProviderSpec: BasicNumericTickProviderSpec(desiredTickCount: 9),
              tickFormatterSpec: dBTickFormatter,
            ),
            primaryMeasureAxis: NumericAxisSpec(
              tickProviderSpec: BasicNumericTickProviderSpec(desiredTickCount: 10),
              showAxisLine: true
              // tickFormatterSpec: hZTickFormatter,
            ),
            behaviors: [
              LinePointHighlighter(
                symbolRenderer: CustomCircleSymbolRenderer(),
                drawFollowLinesAcrossChart: true,
                showHorizontalFollowLine: LinePointHighlighterFollowLineType.all,
              ),
              RangeAnnotation([
                RangeAnnotationSegment(
                  40.0, 20.0, RangeAnnotationAxisType.measure, color: Color.fromHex(code: '#72CC82')
                ),
                RangeAnnotationSegment(
                  80.0, 40.0, RangeAnnotationAxisType.measure, color: Color.fromHex(code: '#FFD700')
                ),
                RangeAnnotationSegment(
                  120.0, 80.0, RangeAnnotationAxisType.measure, color: ColorUtil.fromDartColor(Colors.red.shade300)
                ),
              ]),
              ChartTitle(
                'dB',
                behaviorPosition: BehaviorPosition.start,
                titleOutsideJustification: OutsideJustification.middleDrawArea
              ),
              ChartTitle(
                'Hz',
                behaviorPosition: BehaviorPosition.bottom,
                titleOutsideJustification: OutsideJustification.middleDrawArea
              ),
            ],
            selectionModels: [
              SelectionModelConfig(
                changedListener: (SelectionModel model) {
                  if(model.hasDatumSelection) {
                    final int value = model.selectedSeries[0].measureFn(model.selectedDatum[0].index);
                    CustomCircleSymbolRenderer.value = value;
                  }
                }
              )
            ],
          );
        }

        // 불어오는데 시간이 걸려서? 로딩하는동안 빈 화면을 만들기 위해
        else return Text('');
      },
    );
  }

  List<Series<Graph, int>> _setChartData(List<double> dBData) {
    final List<Graph> data = [
      Graph(-20, -1),
      Graph(null, -1), // 첫 번째 점과 두 번째 점을 끊기 위해 임의로 null 설정
      Graph(dBData[0].toInt(), 0),
      Graph(dBData[1].toInt(), 1),
      Graph(dBData[2].toInt(), 2),
      Graph(dBData[3].toInt(), 3),
      Graph(dBData[4].toInt(), 4),
      Graph(dBData[5].toInt(), 5),
      Graph(dBData[6].toInt(), 6),
      Graph(null, -1),
      Graph(160, -1),
    ];

    return [
     Series(
        id: 'earcheck',
        data: data,
        domainFn: (Graph d, _) => d.hZ,
        measureFn: (Graph d, _) => d.dB
      )
    ];
  }

  final dBTickFormatter = BasicNumericTickFormatterSpec((num i) {
    String res;

    switch(i) {
      case -1: res = "";   break;
      case 0: res = "125"; break;
      case 1: res = "250"; break;
      case 2: res = "500"; break;
      case 3: res = "1K";  break;
      case 4: res = "2K";  break;
      case 5: res = "4K";  break;
      case 6: res = "8K";  break;
      case 7: res = "";    break;
    }

    return res;
  });

  final hZTickFormatter = BasicNumericTickFormatterSpec((num i) {
    String res;

    switch(i) {
      case -20: res = "125"; break;
      case 50: res = "250";  break;
      case 55: res = "500";  break;
      case 60: res = "1K";   break;
      case 30: res = "2K";   break;
      case 40: res = "4K";   break;
      case 70: res = "8K";   break;
    }

    return res;
  });
}
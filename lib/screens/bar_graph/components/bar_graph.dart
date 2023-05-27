import 'package:everyday/screens/bar_graph/components/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  const BarGraph(
      {super.key,
      required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thuAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.bardata
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.deepPurple[600],
                    width: 20,
                    borderRadius: BorderRadius.circular(8),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: const Color(0xffbb86fc).withOpacity(0.2),
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xffbb86fc),
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Sun', style: style);
      break;
    case 1:
      text = const Text('Mon', style: style);
      break;
    case 2:
      text = const Text('Tue', style: style);
      break;
    case 3:
      text = const Text('Wed', style: style);
      break;
    case 4:
      text = const Text('Thu', style: style);
      break;
    case 5:
      text = const Text('Fri', style: style);
      break;
    case 6:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

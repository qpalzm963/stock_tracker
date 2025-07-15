import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/stock_history.dart';

class StockLineChart extends StatelessWidget {
  final List<StockHistory> history;
  const StockLineChart({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final closeList = history.map((e) => e.close).toList();
    final ma5 = _calcMA(closeList, 5);

    return LineChart(
      LineChartData(
        minY: history.map((e) => e.low).reduce((a, b) => a < b ? a : b) * 0.98,
        maxY: history.map((e) => e.high).reduce((a, b) => a > b ? a : b) * 1.02,
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < history.length; i++)
                FlSpot(i.toDouble(), history[i].close),
            ],
            isCurved: false,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: [
              for (int i = 0; i < ma5.length; i++)
                if (ma5[i] != 0) FlSpot(i.toDouble(), ma5[i]),
            ],
            isCurved: false,
            color: Colors.orange,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx % 5 == 0 && idx < history.length) {
                  final d = history[idx].date;
                  return Text('${d.month}/${d.day}', style: TextStyle(fontSize: 10));
                }
                return Container();
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }

  List<double> _calcMA(List<double> close, int days) {
    List<double> ma = [];
    for (int i = 0; i < close.length; i++) {
      if (i < days - 1) {
        ma.add(0);
      } else {
        final avg = close.sublist(i - days + 1, i + 1).reduce((a, b) => a + b) / days;
        ma.add(avg);
      }
    }
    return ma;
  }
}
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stock_tracker/models/stock_history.dart';

class VolumeBarChart extends StatelessWidget {
  final List<StockHistory> history;
  const VolumeBarChart({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final bars = [
      for (int i = 0; i < history.length; i++)
        BarChartRodData(
          toY: history[i].volume,
          color: history[i].close >= history[i].open
              ? Colors.red
              : Colors.green, // 漲紅跌綠
          width: 6,
        ),
    ];
    final minVol = history.map((e) => e.volume).reduce((a, b) => a < b ? a : b);
    final maxVol = history.map((e) => e.volume).reduce((a, b) => a > b ? a : b);
    final interval = (maxVol - minVol) / 4;
    final ticks = [
      minVol,
      minVol + interval,
      minVol + interval * 2,
      minVol + interval * 3,
      maxVol
    ]; // 五筆

    return BarChart(
      BarChartData(
        barGroups: [
          for (int i = 0; i < history.length; i++)
            BarChartGroupData(x: i, barRods: [bars[i]]),
        ],
        gridData: FlGridData(
          show: true,
          horizontalInterval: interval,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey.withOpacity(0.08), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          // 左邊成交量數字
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              interval: interval,
              getTitlesWidget: (value, meta) {
                String vol = value >= 1000000
                    ? '${(value / 1000000).toStringAsFixed(1)}M'
                    : value >= 1000
                        ? '${(value / 1000).toStringAsFixed(0)}K'
                        : value.toStringAsFixed(0);

                if (ticks.any((tick) => (value - tick).abs() < 1)) {
                  return Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Text(
                      vol,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),

          // 底部顯示日期（可配合 K 線圖對齊）
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                int idx = value.toInt();
                if (idx % 5 == 0 && idx < history.length) {
                  final d = history[idx].date;
                  return Text(
                    '${d.month}/${d.day}',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(enabled: false),
        minY: minVol,
        maxY: maxVol,
      ),
    );
  }
}

double _suggestVolumeInterval(List<StockHistory> history) {
  final maxVolume = history
      .map((e) => e.volume)
      .reduce((a, b) => a > b ? a : b);
  // 自動設定間隔
  if (maxVolume >= 10 * 10000 * 1000) return 10000000;
  if (maxVolume >= 1 * 10000 * 1000) return 1000000;
  if (maxVolume >= 100 * 10000) return 100000;
  if (maxVolume >= 10 * 10000) return 10000;
  if (maxVolume >= 1000) return 1000;
  return 100;
  return 100;
}

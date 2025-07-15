import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/stock_history.dart';

class DailyCandlestickChartWithMA extends StatelessWidget {
  final List<StockHistory> history;

  const DailyCandlestickChartWithMA({super.key, required this.history});
  List<double> calculateMA(List<StockHistory> data, int window) {
    List<double> ma = [];
    for (int i = 0; i < data.length; i++) {
      if (i + 1 < window) {
        ma.add(0); // 前面湊不滿N日先填0
      } else {
        double sum = 0;
        for (int j = i + 1 - window; j <= i; j++) {
          sum += data[j].close;
        }
        ma.add(sum / window);
      }
    }
    return ma;
  }

  @override
  Widget build(BuildContext context) {
    final candles = [
      for (int i = 0; i < history.length; i++)
        CandlestickSpot(
          x: i.toDouble(),
          open: history[i].open,
          high: history[i].high,
          low: history[i].low,
          close: history[i].close,
        ),
    ];
    final ma5 = calculateMA(history, 5);
    final ma10 = calculateMA(history, 10);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Stack(
        children: [
          // K線圖在下層
          CandlestickChart(
            CandlestickChartData( 
              gridData: FlGridData(show: true, drawVerticalLine: false),
              // ...titlesData, borderData 同前
            ),
          ),
          // MA5 線 (黃色)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _MaLinePainter(values: ma5, color: Colors.orange),
              ),
            ),
          ),
          // MA10 線 (藍色)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _MaLinePainter(values: ma10, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaLinePainter extends CustomPainter {
  final List<double> values;
  final Color color;
  _MaLinePainter({required this.values, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final validPoints = [
      for (int i = 0; i < values.length; i++)
        if (values[i] != 0)
          Offset(
            i * size.width / (values.length - 1),
            size.height - (values[i] - _minY) / (_maxY - _minY) * size.height,
          ),
    ];
    if (validPoints.length < 2) return;
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;
    final path = Path()..moveTo(validPoints.first.dx, validPoints.first.dy);
    for (final p in validPoints.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(path, paint);
  }

  double get _minY =>
      values.where((v) => v != 0).reduce((a, b) => a < b ? a : b);
  double get _maxY =>
      values.where((v) => v != 0).reduce((a, b) => a > b ? a : b);

  @override
  bool shouldRepaint(covariant _MaLinePainter old) =>
      old.values != values || old.color != color;
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/stock_history.dart';

List<CandlestickSpot> toFlCandles(List<StockHistory> history) {
  return [
    for (int i = 0; i < history.length; i++)
      CandlestickSpot(
        x: i.toDouble(),
        open: history[i].open,
        high: history[i].high,
        low: history[i].low,
        close: history[i].close,
      ),
  ];
}

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

class DailyCandlestickChart extends StatelessWidget {
  final List<StockHistory> history;

  const DailyCandlestickChart({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final candles = toFlCandles(history);

    final ma5 = calculateMA(history, 5);
    final ma10 = calculateMA(history, 10);

    return AspectRatio(
      aspectRatio: 1.5,
      child: Stack(
        children: [
          CandlestickChart(
            CandlestickChartData(
              candlestickTouchData: CandlestickTouchData(
                enabled: true,
                touchTooltipData: CandlestickTouchTooltipData(
                  getTooltipItems: (painter, touchedSpot, spotIndex) {
                    final o = touchedSpot.open.toStringAsFixed(2);
                    final h = touchedSpot.high.toStringAsFixed(2);
                    final l = touchedSpot.low.toStringAsFixed(2);
                    final c = touchedSpot.close.toStringAsFixed(2);

                    return CandlestickTooltipItem(
                      '開: $o\n高: $h\n低: $l\n收: $c',
                      textStyle: TextStyle(color: Colors.white, fontSize: 14),
                    );
                  },
                ),
              ),
              candlestickSpots: candles,
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(reservedSize: 30),
                ),
                leftTitles: AxisTitles(
                  drawBelowEverything: true,
                  sideTitles: SideTitles(
                    showTitles: true,
                    maxIncluded: false,
                    minIncluded: false,
                    reservedSize: 60,
                    getTitlesWidget:
                        (value, meta) => Text(
                          value.toStringAsFixed(2),
                          style: TextStyle(color: Colors.amber),
                        ),
                  ),
                ),

                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 40,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // 每五天顯示一個日期
                      final idx = value.toInt();
                      if (idx % 5 == 0 && idx < history.length) {
                        final d = history[idx].date;
                        return Text(
                          '${d.month}/${d.day}',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),

              // 其他屬性都可調整
              touchedPointIndicator: AxisSpotIndicator(
                painter: AxisLinesIndicatorPainter(
                  verticalLineProvider: (x) {
                    final data = candles[x.toInt()];
                    return VerticalLine(
                      x: x,
                      color: (data.isUp ? Colors.green : Colors.red).withValues(
                        alpha: 0.5,
                      ),
                      strokeWidth: 1,
                    );
                  },
                  horizontalLineProvider:
                      (y) => HorizontalLine(
                        y: y,
                        label: HorizontalLineLabel(
                          show: true,
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          labelResolver:
                              (hLine) => hLine.y.toStringAsFixed(2).toString(),
                          alignment: Alignment.topLeft,
                        ),
                        color: Colors.yellow.withValues(alpha: 0.8),
                        strokeWidth: 1,
                      ),
                ),
              ),
            ),
          ),
          // MA5 線 (黃色)
          // Positioned.fill(
          //   child: IgnorePointer(
          //     child: CustomPaint(
          //       painter: _MaLinePainter(values: ma5, color: Colors.orange),
          //     ),
          //   ),
          // ),
          // // MA10 線 (藍色)
          // Positioned.fill(
          //   child: IgnorePointer(
          //     child: CustomPaint(
          //       painter: _MaLinePainter(values: ma10, color: Colors.blue),
          //     ),
          //   ),
          // ),
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

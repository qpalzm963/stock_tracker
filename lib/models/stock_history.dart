class StockHistory {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  StockHistory({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}
class Stock {
  final String symbol; // 股票代碼，如 'AAPL', '2330.TW'
  final String name; // 公司名稱（暫用 symbol 也可）
  final double price; // 現價
  final double change; // 漲跌金額（可選，暫設 0）
  final double percent; // 漲跌幅（%）（可選，暫設 0）
  final double high; // 最高價
  final double open; // 開盤價
  final double low; // 最低價
  final String updatedAt; // 更新時間

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.percent,
    required this.high,
    required this.low,
    required this.open,
    required this.updatedAt,
  });

  factory Stock.fromQuoteJson(
    Map<String, dynamic> data, {
    required String symbol,
    required String name,
  }) {
    final price = (data['c'] as num?)?.toDouble() ?? 0.0;
    final prevClose = (data['pc'] as num?)?.toDouble() ?? 0.0;
    final change = price - prevClose;
    final percent = prevClose > 0 ? (change / prevClose) * 100 : 0.0;

    return Stock(
      symbol: symbol,
      name: name,
      price: price,
      change: change,
      percent: percent,
      high: (data['h'] as num?)?.toDouble() ?? 0.0,
      open: (data['o'] as num?)?.toDouble() ?? 0.0,
      low: (data['l'] as num?)?.toDouble() ?? 0.0,
      updatedAt:
          DateTime.fromMillisecondsSinceEpoch(
            (data['t'] as int? ?? 0) * 1000,
          ).toIso8601String(),
    );
  }
}

class StockInfo {
  final String code; // 公司代號
  final String name; // 公司名稱
  final String enName; // 英文簡稱

  StockInfo({required this.code, required this.name, required this.enName});

  factory StockInfo.fromJson(Map<String, dynamic> json) => StockInfo(
    code: json['公司代號'] ?? '',
    name: json['公司名稱'] ?? '',
    enName: json['英文簡稱'] ?? '',
  );
}

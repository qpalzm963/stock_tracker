class TwseStockInfo {
  final String symbol; // 股票代碼 e.g. 2330.tw
  final String name; // 公司名稱 e.g. 台積電
  final String fullname; // 公司全名 e.g. 台灣積體電路製造股份有限公司
  final DateTime date; // 報價日期 e.g. 2025-06-30
  final String time; // 報價時間 e.g. 10:38:10
  final double open; // 開盤價 o
  final double high; // 最高價 h
  final double low; // 最低價 l
  final double price; // 成交價 z
  final double yesterday; // 昨收 y
  final double volume; // 成交量 v
  final double upperLimit; // 漲停 u
  final double lowerLimit; // 跌停 w
  final List<double> ask; // 五檔賣價 a（下底線分隔）
  final List<double> bid; // 五檔買價 b（下底線分隔）
  final List<int> askVol; // 五檔賣量 f
  final List<int> bidVol; // 五檔買量 g

  TwseStockInfo({
    required this.symbol,
    required this.name,
    required this.fullname,
    required this.date,
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.price,
    required this.yesterday,
    required this.volume,
    required this.upperLimit,
    required this.lowerLimit,
    required this.ask,
    required this.bid,
    required this.askVol,
    required this.bidVol,
  });

  factory TwseStockInfo.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic v) =>
        (v == null || v == '-' || v == '')
            ? 0.0
            : double.tryParse(v.toString().replaceAll(',', '')) ?? 0.0;
    int parseInt(dynamic v) =>
        (v == null || v == '-' || v == '')
            ? 0
            : int.tryParse(v.toString().replaceAll(',', '')) ?? 0;

    // 五檔價/量下底線結尾，要 split filter
    List<double> parsePriceList(String? s) =>
        (s ?? '')
            .split('_')
            .where((e) => e.isNotEmpty)
            .map(parseDouble)
            .toList();
    List<int> parseIntList(String? s) =>
        (s ?? '').split('_').where((e) => e.isNotEmpty).map(parseInt).toList();

    // 日期格式 20250630
    DateTime parseDate(String? s) {
      if (s == null || s.length != 8) return DateTime.now();
      final year = int.parse(s.substring(0, 4));
      final month = int.parse(s.substring(4, 6));
      final day = int.parse(s.substring(6, 8));
      return DateTime(year, month, day);
    }

    return TwseStockInfo(
      symbol: json['c'] ?? json['@'] ?? '',
      name: json['n'] ?? '',
      fullname: json['nf'] ?? '',
      date: parseDate(json['d']),
      time: json['t'] ?? '',
      open: parseDouble(json['o']),
      high: parseDouble(json['h']),
      low: parseDouble(json['l']),
      price: parseDouble(json['z']),
      yesterday: parseDouble(json['y']),
      volume: parseDouble(json['v']),
      upperLimit: parseDouble(json['u']),
      lowerLimit: parseDouble(json['w']),
      ask: parsePriceList(json['a']),
      bid: parsePriceList(json['b']),
      askVol: parseIntList(json['f']),
      bidVol: parseIntList(json['g']),
    );
  }
}

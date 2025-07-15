// lib/api/stock_api.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:stock_tracker/models/stock.dart';
import 'package:stock_tracker/models/stock_history.dart';
import 'package:stock_tracker/models/twse_stock_info.dart';

final apiKey = dotenv.env['STOCK_API_KEY'];

class StockApi {
  StockApi();

  /// 根據自選股清單即時抓行情
  Future<Stock?> fetchQuoteByFinnhub(String symbol) async {
    final url =
        'https://finnhub.io/api/v1/quote?symbol=$symbol.TW&token=$apiKey';
    final resp = await http.get(Uri.parse(url));
    print("resp ${resp.body}");
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      return Stock.fromQuoteJson(data, symbol: symbol, name: '');
    } else {
      return null;
    }
  }

  Future<TwseStockInfo?> fetchQuote(String symbol) async {
    // 台灣證交所 API，symbol 需為 4 位數字TwseStockInfo
    final url =
        'https://mis.twse.com.tw/stock/api/getStockInfo.jsp?ex_ch=tse_$symbol.tw';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      final msgArray = data['msgArray'] as List?;
      if (msgArray != null && msgArray.isNotEmpty) {
        return TwseStockInfo.fromJson(msgArray[0]);
      }
      return null;
    } else {
      return null;
    }
  }

  Future<List<StockHistory>> fetchHalfYearHistory(String symbol) async {
    final now = DateTime.now();
    final List<StockHistory> allHistory = [];

    for (int i = 0; i < 6; i++) {
      final date = DateTime(now.year, now.month - i, 1);
      final year = date.year;
      final month = date.month;
      try {
        final monthlyData = await fetchMonthlyHistory(symbol, year, month);
        allHistory.addAll(monthlyData);
      } catch (e) {
        // 可以選擇忽略或處理錯誤
      }
    }

    // 過濾掉超過半年前的資料
    final halfYearAgo = now.subtract(const Duration(days: 182));
    allHistory.retainWhere((item) {
      final itemDate = (item.date);
      return itemDate.isAfter(halfYearAgo) ||
          itemDate.isAtSameMomentAs(halfYearAgo);
    });

    // 依日期排序（由新到舊）
    allHistory.sort((a, b) => b.date.compareTo(a.date));

    return allHistory;
  }

  Future<List<StockHistory>> fetchMonthlyHistory(
    String stockNo,
    int year,
    int month,
  ) async {
    final dateStr = '$year${month.toString().padLeft(2, '0')}01';
    final url =
        'https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=json&date=$dateStr&stockNo=$stockNo';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      final List records = data['data'];
      final List<StockHistory> list = [];
      for (var row in records) {
        // [日期, 成交股數, 成交金額, 開盤價, 最高價, 最低價, 收盤價, 漲跌價差, 成交筆數]
        final dateParts = (row[0] as String).split('/');
        final int y = int.parse(dateParts[0]) + 1911;
        final int m = int.parse(dateParts[1]);
        final int d = int.parse(dateParts[2]);
        double parseNum(String v) =>
            double.tryParse(v.replaceAll(',', '').replaceAll('--', '0')) ?? 0;
        list.add(
          StockHistory(
            date: DateTime(y, m, d),
            open: parseNum(row[3]),
            high: parseNum(row[4]),
            low: parseNum(row[5]),
            close: parseNum(row[6]),
            volume: parseNum(row[1]),
          ),
        );
      }
      return list;
    } else {
      throw Exception('TWSE API error: ${resp.body}');
    }
  }
}

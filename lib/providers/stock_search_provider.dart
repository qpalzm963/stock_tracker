import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stock_tracker/models/stock.dart';

part 'stock_search_provider.g.dart';

Future<List<StockInfo>> loadStockListFromAsset() async {
  final jsonStr = await rootBundle.loadString('assets/stocks.json');
  final List data = json.decode(jsonStr);
  return data.map((e) => StockInfo.fromJson(e)).toList();
}

@Riverpod(keepAlive: true)
Future<List<StockInfo>> allStocks(Ref ref) => loadStockListFromAsset();
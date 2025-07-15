// lib/providers/stock_provider.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stock_tracker/models/stock.dart';
import 'package:stock_tracker/models/stock_history.dart';
import 'package:stock_tracker/models/twse_stock_info.dart';
import '../api/stock_api.dart';

part 'stock_provider.g.dart';

@riverpod
StockApi stockApi(ref) => StockApi();

@riverpod
Future<TwseStockInfo?> stockPrice(ref, String symbol) {
  StockApi api = ref.watch(stockApiProvider);
  return api.fetchQuote(symbol);
}

@riverpod
Stream<Stock> singleStockStream(Ref ref, String symbol) async* {
  final api = ref.watch(stockApiProvider);
  while (true) {
    final data = await api.fetchQuote(symbol);
    final price = data?.price ?? 0;
    final prevClose = data?.yesterday ?? 0;
    double change = 0;
    double percent = 0;
    if (price > 0 && prevClose > 0) {
      change = price - prevClose;
      percent = (change / prevClose) * 100;
    }
    yield Stock(
      symbol: symbol,
      open: data?.open ?? 0,
      name: data?.name ?? symbol,
      price: price,
      change: change,
      percent: percent,
      high: data?.high ?? 0,
      low: data?.low ?? 0,
      updatedAt: data?.time ?? "",
    );
    await Future.delayed(const Duration(seconds: 10)); // 每10秒刷新一次
  }
}

@riverpod
Future<List<StockHistory>> twseStockHistory(
  Ref ref,
  String stockNo,
  int year,
  int month,
) async {
  final api = ref.watch(stockApiProvider);
  return api.fetchMonthlyHistory(stockNo, year, month);
}

@riverpod
Future<List<StockHistory>> fetchYearHistory(Ref ref, String stockNo) async {
  final api = ref.watch(stockApiProvider);
  return api.fetchHalfYearHistory(stockNo);
}

// /// 管理自選股票清單
// @riverpod
// class FavoriteStocksNotifier extends _$FavoriteStocksNotifier {
//   @override
//   List<String> build() => []; // 初始清單

//   void add(String symbol) {
//     if (!state.contains(symbol)) {
//       state = [...state, symbol];
//     }
//   }

//   void remove(String symbol) {
//     state = state.where((s) => s != symbol).toList();
//   }
// }

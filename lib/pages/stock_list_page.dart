import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stock_tracker/pages/stock_detail_page.dart';
import 'package:stock_tracker/providers/favorite_stocks_notifier.dart';
import 'package:stock_tracker/providers/stock_search_provider.dart';
import 'package:stock_tracker/widgets/stock_search_dripdown.dart';
import 'package:stock_tracker/widgets/stock_tile.dart';
import '../providers/stock_provider.dart';

class StockListPage extends HookConsumerWidget {
  const StockListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteStocksNotifierProvider);
    final favNotifier = ref.read(favoriteStocksNotifierProvider.notifier);

    ref.read(allStocksProvider.future);

    return Scaffold(
      appBar: AppBar(title: Text('自選股追蹤')),
      body: Column(
        children: [
          StockSearchDropdown(
            onFocus: (p0) => favNotifier.add(p0!.code),
            onSelected: (e) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => StockDetailPage(symbol: e!.code, name: e.name),
                ),
              );
            },
          ),
          SizedBox(height: 15),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // 重新觸發所有股票的刷新
                for (final symbol in favorites) {
                  ref.invalidate(singleStockStreamProvider(symbol));
                }
                // 可選：等待所有刷新完成
                await Future.delayed(Duration(milliseconds: 500));
              },
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, i) {
                  final symbol = favorites[i];
                  return Consumer(
                    builder: (context, ref, _) {
                      final stockAsync = ref.watch(
                        singleStockStreamProvider(symbol),
                      );
                      return stockAsync.when(
                        data:
                            (s) => StockTile(
                              s: s,
                              onRemove: favNotifier.remove,
                              context: context,
                            ),
                        loading:
                            () => ListTile(
                              key: Key(symbol),
                              title: Text(symbol),
                              subtitle: Text('載入中...'),
                            ),
                        error:
                            (e, _) => ListTile(
                              key: Key(symbol),
                              title: Text(symbol),
                              subtitle: Text('錯誤: $e'),
                            ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

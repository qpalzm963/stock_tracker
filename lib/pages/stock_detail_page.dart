import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stock_tracker/providers/stock_provider.dart';
import 'package:stock_tracker/widgets/daily_candlestick_chart.dart';
import 'package:stock_tracker/widgets/valume_bar_chart.dart';

class StockDetailPage extends HookConsumerWidget {
  final String symbol;
  final String name;
  const StockDetailPage({super.key, required this.symbol, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = ref.watch(_selectedMonthProvider);

    // 取得選擇年月的歷史資料
    final historyAsync = ref.watch(
      TwseStockHistoryProvider(symbol, selectedMonth.year, selectedMonth.month),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 14, 43),
      appBar: AppBar(title: Text('$symbol $name')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$symbol $name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _MonthDropdown(selectedMonth: selectedMonth),
              ],
            ),
            const SizedBox(height: 30),
            // K 線圖表區
            Expanded(
              child: historyAsync.when(
                data: (history) {
                  if (history.isEmpty) return Center(child: Text('查無資料'));
                  return Column(
                    children: [
                      Expanded(child: DailyCandlestickChart(history: history)),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 150,
                        child: VolumeBarChart(history: history),
                      ),
                      Text('最新收盤：${history.last.close}'),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (e, _) => Center(
                      child: Text(
                        '查無資料',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 用 StateProvider 存當前選擇月份
final _selectedMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
});

/// 月份下拉選單 Widget
class _MonthDropdown extends ConsumerWidget {
  final DateTime selectedMonth;
  const _MonthDropdown({required this.selectedMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    // 近 12 個月列表（你可調整區間）
    final months = List.generate(12, (i) {
      final d = DateTime(now.year, now.month - i);
      return DateTime(d.year, d.month);
    });

    return DropdownButton<DateTime>(
      dropdownColor: Colors.black,
      value: selectedMonth,
      items:
          months.map((date) {
            final label =
                '${date.year}-${date.month.toString().padLeft(2, '0')}';
            return DropdownMenuItem(
              value: date,
              child: Text(label, style: TextStyle(color: Colors.white)),
            );
          }).toList(),
      onChanged: (value) {
        if (value != null) {
          ref.read(_selectedMonthProvider.notifier).state = value;
        }
      },
    );
  }
}

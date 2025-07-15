import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StockChart extends HookConsumerWidget {
  final String symbol;
  const StockChart({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox();
    //     final history = ref.watch(stockHistoryProvider(symbol));
    //     return history.when(
    //       data: (list) => LineChart(LineChartData(
    //         lineBarsData: [
    //           LineChartBarData(
    //             spots: [
    //               for (var h in list)
    //                 FlSpot(h.date.millisecondsSinceEpoch.toDouble(), h.close),
    //             ],
    //             isCurved: true,
    //             color: Colors.blue,
    //           ),
    //         ],
    //         // 這裡可自訂 X/Y 軸、grid、顏色等
    //       )),
    //       loading: () => const CircularProgressIndicator(),
    //       error: (e, _) => Text('錯誤: $e'),
    //     );
    //   }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stock_tracker/models/stock.dart';
import 'package:stock_tracker/providers/stock_search_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StockSearchDropdown extends HookConsumerWidget {
  final void Function(StockInfo?)? onSelected;
  final void Function(StockInfo?)? onFocus;
  const StockSearchDropdown({super.key, this.onSelected, this.onFocus});

  @override
  Widget build(context, WidgetRef ref) {
    final stocksAsync = ref.watch(allStocksProvider);
    final textEditController = useTextEditingController();
    final stocks = stocksAsync.value ?? [];

    return TypeAheadField<StockInfo>(
      controller: textEditController,
      emptyBuilder: (context) => Text('輸入股票代號'),

      suggestionsCallback: (pattern) {
        if (pattern.isEmpty) return [];
        final kw = pattern.toLowerCase();
        return stocks
            .where(
              (s) =>
                  s.code.contains(kw) ||
                  s.name.contains(kw) ||
                  s.enName.toLowerCase().contains(kw),
            )
            .toList();
      },
      itemBuilder: (context, StockInfo stock) {
        return ListTile(
          title: Text('${stock.code} ${stock.name}'),
          subtitle: Text(stock.enName),
          trailing: GestureDetector(
            onTap: () {
              onFocus!(stock);
              textEditController.clear();
            },
            child: Icon(Icons.add),
          ),
        );
      },
      onSelected: onSelected,
      hideOnEmpty: true,
      hideOnError: true,
      // hideSuggestionsOnKeyboardHide: false,
      // suggestionsBoxDecoration: SuggestionsBoxDecoration(
      //   elevation: 4,
      //   borderRadius: BorderRadius.circular(8),
      // ),
      // noItemsFoundBuilder:
      //     (context) => Padding(
      //       padding: EdgeInsets.all(8),
      //       child: Text('查無此股票', style: TextStyle(color: Colors.grey)),
      //     ),
      loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
    );
  }
}

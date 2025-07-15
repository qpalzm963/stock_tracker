import 'package:flutter/material.dart';
import 'package:stock_tracker/models/stock.dart';
import 'package:stock_tracker/pages/stock_detail_page.dart';

class StockTile extends StatelessWidget {
  final Stock s;
  final Function(String s) onRemove;
  final BuildContext context;

  const StockTile({
    Key? key,
    required this.s,
    required this.onRemove,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile( 
      title: Text('${s.symbol} ${s.name}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('現價: ${s.price} 開盤:${s.open} 最高:${s.high} 最低:${s.low}',style: TextStyle(),),
          Row(
            children: [
              Icon(
                s.change < 0 ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                color: s.change < 0 ? Colors.green : Colors.red,
              ),
              Text(
                '${s.change.toStringAsFixed(2)} / ${s.percent.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: s.change < 0 ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
      trailing: Wrap(
        children: [
          Text(s.updatedAt),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onRemove(s.symbol),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StockDetailPage(symbol: s.symbol, name: s.name),
          ),
        );
      },
    );
  }
}

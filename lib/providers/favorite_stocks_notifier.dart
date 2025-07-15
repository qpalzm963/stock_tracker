import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite_stocks_notifier.g.dart';

const _prefsKey = 'favorite_stocks';

@riverpod
class FavoriteStocksNotifier extends _$FavoriteStocksNotifier {
  @override
  List<String> build() {
    _loadFromPrefs(); // 非同步讀取
    return [];
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final symbols = prefs.getStringList(_prefsKey);
    if (symbols != null) {
      state = symbols;
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, state);
  }

  void add(String symbol) {
    if (!state.contains(symbol)) {
      state = [...state, symbol];
      _saveToPrefs();
    }
  }

  void remove(String symbol) {
    state = state.where((s) => s != symbol).toList();
    _saveToPrefs();
  }
}

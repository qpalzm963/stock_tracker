// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stockApiHash() => r'd861d9439c1683b8a8ada98baf2dc435ff699fa7';

/// See also [stockApi].
@ProviderFor(stockApi)
final stockApiProvider = AutoDisposeProvider<StockApi>.internal(
  stockApi,
  name: r'stockApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$stockApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StockApiRef = AutoDisposeProviderRef<StockApi>;
String _$stockPriceHash() => r'b982c02e89e8d8ae6de3e86fde5c9f91a96745f7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [stockPrice].
@ProviderFor(stockPrice)
const stockPriceProvider = StockPriceFamily();

/// See also [stockPrice].
class StockPriceFamily extends Family<AsyncValue<TwseStockInfo?>> {
  /// See also [stockPrice].
  const StockPriceFamily();

  /// See also [stockPrice].
  StockPriceProvider call(String symbol) {
    return StockPriceProvider(symbol);
  }

  @override
  StockPriceProvider getProviderOverride(
    covariant StockPriceProvider provider,
  ) {
    return call(provider.symbol);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'stockPriceProvider';
}

/// See also [stockPrice].
class StockPriceProvider extends AutoDisposeFutureProvider<TwseStockInfo?> {
  /// See also [stockPrice].
  StockPriceProvider(String symbol)
    : this._internal(
        (ref) => stockPrice(ref as StockPriceRef, symbol),
        from: stockPriceProvider,
        name: r'stockPriceProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$stockPriceHash,
        dependencies: StockPriceFamily._dependencies,
        allTransitiveDependencies: StockPriceFamily._allTransitiveDependencies,
        symbol: symbol,
      );

  StockPriceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.symbol,
  }) : super.internal();

  final String symbol;

  @override
  Override overrideWith(
    FutureOr<TwseStockInfo?> Function(StockPriceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StockPriceProvider._internal(
        (ref) => create(ref as StockPriceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        symbol: symbol,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TwseStockInfo?> createElement() {
    return _StockPriceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StockPriceProvider && other.symbol == symbol;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, symbol.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StockPriceRef on AutoDisposeFutureProviderRef<TwseStockInfo?> {
  /// The parameter `symbol` of this provider.
  String get symbol;
}

class _StockPriceProviderElement
    extends AutoDisposeFutureProviderElement<TwseStockInfo?>
    with StockPriceRef {
  _StockPriceProviderElement(super.provider);

  @override
  String get symbol => (origin as StockPriceProvider).symbol;
}

String _$singleStockStreamHash() => r'a9232cfb74bf9ab9f4404e75ee372fc6a3bb6eda';

/// See also [singleStockStream].
@ProviderFor(singleStockStream)
const singleStockStreamProvider = SingleStockStreamFamily();

/// See also [singleStockStream].
class SingleStockStreamFamily extends Family<AsyncValue<Stock>> {
  /// See also [singleStockStream].
  const SingleStockStreamFamily();

  /// See also [singleStockStream].
  SingleStockStreamProvider call(String symbol) {
    return SingleStockStreamProvider(symbol);
  }

  @override
  SingleStockStreamProvider getProviderOverride(
    covariant SingleStockStreamProvider provider,
  ) {
    return call(provider.symbol);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleStockStreamProvider';
}

/// See also [singleStockStream].
class SingleStockStreamProvider extends AutoDisposeStreamProvider<Stock> {
  /// See also [singleStockStream].
  SingleStockStreamProvider(String symbol)
    : this._internal(
        (ref) => singleStockStream(ref as SingleStockStreamRef, symbol),
        from: singleStockStreamProvider,
        name: r'singleStockStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$singleStockStreamHash,
        dependencies: SingleStockStreamFamily._dependencies,
        allTransitiveDependencies:
            SingleStockStreamFamily._allTransitiveDependencies,
        symbol: symbol,
      );

  SingleStockStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.symbol,
  }) : super.internal();

  final String symbol;

  @override
  Override overrideWith(
    Stream<Stock> Function(SingleStockStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SingleStockStreamProvider._internal(
        (ref) => create(ref as SingleStockStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        symbol: symbol,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Stock> createElement() {
    return _SingleStockStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleStockStreamProvider && other.symbol == symbol;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, symbol.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SingleStockStreamRef on AutoDisposeStreamProviderRef<Stock> {
  /// The parameter `symbol` of this provider.
  String get symbol;
}

class _SingleStockStreamProviderElement
    extends AutoDisposeStreamProviderElement<Stock>
    with SingleStockStreamRef {
  _SingleStockStreamProviderElement(super.provider);

  @override
  String get symbol => (origin as SingleStockStreamProvider).symbol;
}

String _$twseStockHistoryHash() => r'd880dd1daf691306ccdd8df2be075a1c1833620b';

/// See also [twseStockHistory].
@ProviderFor(twseStockHistory)
const twseStockHistoryProvider = TwseStockHistoryFamily();

/// See also [twseStockHistory].
class TwseStockHistoryFamily extends Family<AsyncValue<List<StockHistory>>> {
  /// See also [twseStockHistory].
  const TwseStockHistoryFamily();

  /// See also [twseStockHistory].
  TwseStockHistoryProvider call(String stockNo, int year, int month) {
    return TwseStockHistoryProvider(stockNo, year, month);
  }

  @override
  TwseStockHistoryProvider getProviderOverride(
    covariant TwseStockHistoryProvider provider,
  ) {
    return call(provider.stockNo, provider.year, provider.month);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'twseStockHistoryProvider';
}

/// See also [twseStockHistory].
class TwseStockHistoryProvider
    extends AutoDisposeFutureProvider<List<StockHistory>> {
  /// See also [twseStockHistory].
  TwseStockHistoryProvider(String stockNo, int year, int month)
    : this._internal(
        (ref) =>
            twseStockHistory(ref as TwseStockHistoryRef, stockNo, year, month),
        from: twseStockHistoryProvider,
        name: r'twseStockHistoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$twseStockHistoryHash,
        dependencies: TwseStockHistoryFamily._dependencies,
        allTransitiveDependencies:
            TwseStockHistoryFamily._allTransitiveDependencies,
        stockNo: stockNo,
        year: year,
        month: month,
      );

  TwseStockHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stockNo,
    required this.year,
    required this.month,
  }) : super.internal();

  final String stockNo;
  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<List<StockHistory>> Function(TwseStockHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TwseStockHistoryProvider._internal(
        (ref) => create(ref as TwseStockHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stockNo: stockNo,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<StockHistory>> createElement() {
    return _TwseStockHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TwseStockHistoryProvider &&
        other.stockNo == stockNo &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stockNo.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TwseStockHistoryRef on AutoDisposeFutureProviderRef<List<StockHistory>> {
  /// The parameter `stockNo` of this provider.
  String get stockNo;

  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _TwseStockHistoryProviderElement
    extends AutoDisposeFutureProviderElement<List<StockHistory>>
    with TwseStockHistoryRef {
  _TwseStockHistoryProviderElement(super.provider);

  @override
  String get stockNo => (origin as TwseStockHistoryProvider).stockNo;
  @override
  int get year => (origin as TwseStockHistoryProvider).year;
  @override
  int get month => (origin as TwseStockHistoryProvider).month;
}

String _$fetchYearHistoryHash() => r'e24e96af9163ce227517079d26a758891f29ca15';

/// See also [fetchYearHistory].
@ProviderFor(fetchYearHistory)
const fetchYearHistoryProvider = FetchYearHistoryFamily();

/// See also [fetchYearHistory].
class FetchYearHistoryFamily extends Family<AsyncValue<List<StockHistory>>> {
  /// See also [fetchYearHistory].
  const FetchYearHistoryFamily();

  /// See also [fetchYearHistory].
  FetchYearHistoryProvider call(String stockNo) {
    return FetchYearHistoryProvider(stockNo);
  }

  @override
  FetchYearHistoryProvider getProviderOverride(
    covariant FetchYearHistoryProvider provider,
  ) {
    return call(provider.stockNo);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchYearHistoryProvider';
}

/// See also [fetchYearHistory].
class FetchYearHistoryProvider
    extends AutoDisposeFutureProvider<List<StockHistory>> {
  /// See also [fetchYearHistory].
  FetchYearHistoryProvider(String stockNo)
    : this._internal(
        (ref) => fetchYearHistory(ref as FetchYearHistoryRef, stockNo),
        from: fetchYearHistoryProvider,
        name: r'fetchYearHistoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchYearHistoryHash,
        dependencies: FetchYearHistoryFamily._dependencies,
        allTransitiveDependencies:
            FetchYearHistoryFamily._allTransitiveDependencies,
        stockNo: stockNo,
      );

  FetchYearHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stockNo,
  }) : super.internal();

  final String stockNo;

  @override
  Override overrideWith(
    FutureOr<List<StockHistory>> Function(FetchYearHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchYearHistoryProvider._internal(
        (ref) => create(ref as FetchYearHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stockNo: stockNo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<StockHistory>> createElement() {
    return _FetchYearHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchYearHistoryProvider && other.stockNo == stockNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stockNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchYearHistoryRef on AutoDisposeFutureProviderRef<List<StockHistory>> {
  /// The parameter `stockNo` of this provider.
  String get stockNo;
}

class _FetchYearHistoryProviderElement
    extends AutoDisposeFutureProviderElement<List<StockHistory>>
    with FetchYearHistoryRef {
  _FetchYearHistoryProviderElement(super.provider);

  @override
  String get stockNo => (origin as FetchYearHistoryProvider).stockNo;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

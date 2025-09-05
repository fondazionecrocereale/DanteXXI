class WalletBalance {
  final int fiorinoBalance; // En microunidades (6 decimales)
  final double usdBalance; // En centavos
  final double fiorinoPrice; // Precio en USD
  final DateTime lastUpdated;

  const WalletBalance({
    required this.fiorinoBalance,
    required this.usdBalance,
    required this.fiorinoPrice,
    required this.lastUpdated,
  });

  factory WalletBalance.empty() {
    return WalletBalance(
      fiorinoBalance: 0,
      usdBalance: 0.0,
      fiorinoPrice: 0.0,
      lastUpdated: DateTime.now(),
    );
  }

  WalletBalance copyWith({
    int? fiorinoBalance,
    double? usdBalance,
    double? fiorinoPrice,
    DateTime? lastUpdated,
  }) {
    return WalletBalance(
      fiorinoBalance: fiorinoBalance ?? this.fiorinoBalance,
      usdBalance: usdBalance ?? this.usdBalance,
      fiorinoPrice: fiorinoPrice ?? this.fiorinoPrice,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WalletBalance &&
        other.fiorinoBalance == fiorinoBalance &&
        other.usdBalance == usdBalance &&
        other.fiorinoPrice == fiorinoPrice &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return fiorinoBalance.hashCode ^
        usdBalance.hashCode ^
        fiorinoPrice.hashCode ^
        lastUpdated.hashCode;
  }

  @override
  String toString() {
    return 'WalletBalance(fiorinoBalance: $fiorinoBalance, usdBalance: $usdBalance, fiorinoPrice: $fiorinoPrice, lastUpdated: $lastUpdated)';
  }
}

enum SwapStatus { pending, processing, completed, failed, cancelled }

class Swap {
  final String id;
  final double mercadopagoAmount; // En ARS
  final int fiorinoAmount; // En microunidades
  final double exchangeRate;
  final SwapStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? mercadopagoTxId;
  final String? fiorinoTxHash;
  final String? errorMessage;

  const Swap({
    required this.id,
    required this.mercadopagoAmount,
    required this.fiorinoAmount,
    required this.exchangeRate,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.mercadopagoTxId,
    this.fiorinoTxHash,
    this.errorMessage,
  });

  factory Swap.fromJson(Map<String, dynamic> json) {
    return Swap(
      id: json['id'] as String,
      mercadopagoAmount: (json['mercadopagoAmount'] as num).toDouble(),
      fiorinoAmount: json['fiorinoAmount'] as int,
      exchangeRate: (json['exchangeRate'] as num).toDouble(),
      status: SwapStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SwapStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      mercadopagoTxId: json['mercadopagoTxId'] as String?,
      fiorinoTxHash: json['fiorinoTxHash'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mercadopagoAmount': mercadopagoAmount,
      'fiorinoAmount': fiorinoAmount,
      'exchangeRate': exchangeRate,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'mercadopagoTxId': mercadopagoTxId,
      'fiorinoTxHash': fiorinoTxHash,
      'errorMessage': errorMessage,
    };
  }

  Swap copyWith({
    String? id,
    double? mercadopagoAmount,
    int? fiorinoAmount,
    double? exchangeRate,
    SwapStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? mercadopagoTxId,
    String? fiorinoTxHash,
    String? errorMessage,
  }) {
    return Swap(
      id: id ?? this.id,
      mercadopagoAmount: mercadopagoAmount ?? this.mercadopagoAmount,
      fiorinoAmount: fiorinoAmount ?? this.fiorinoAmount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      mercadopagoTxId: mercadopagoTxId ?? this.mercadopagoTxId,
      fiorinoTxHash: fiorinoTxHash ?? this.fiorinoTxHash,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Swap &&
        other.id == id &&
        other.mercadopagoAmount == mercadopagoAmount &&
        other.fiorinoAmount == fiorinoAmount &&
        other.exchangeRate == exchangeRate &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.completedAt == completedAt &&
        other.mercadopagoTxId == mercadopagoTxId &&
        other.fiorinoTxHash == fiorinoTxHash &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        mercadopagoAmount.hashCode ^
        fiorinoAmount.hashCode ^
        exchangeRate.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        completedAt.hashCode ^
        mercadopagoTxId.hashCode ^
        fiorinoTxHash.hashCode ^
        errorMessage.hashCode;
  }

  @override
  String toString() {
    return 'Swap(id: $id, mercadopagoAmount: $mercadopagoAmount, fiorinoAmount: $fiorinoAmount, exchangeRate: $exchangeRate, status: $status, createdAt: $createdAt, completedAt: $completedAt, mercadopagoTxId: $mercadopagoTxId, fiorinoTxHash: $fiorinoTxHash, errorMessage: $errorMessage)';
  }
}

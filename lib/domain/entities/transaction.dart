enum TransactionType { send, receive, swap, reward }

enum TransactionStatus { pending, confirmed, failed }

class Transaction {
  final String id;
  final String fromAddress;
  final String toAddress;
  final int amount; // En microunidades
  final TransactionType type;
  final TransactionStatus status;
  final DateTime timestamp;
  final String? memo;
  final String? hash;
  final int? fee; // En microunidades

  const Transaction({
    required this.id,
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
    required this.type,
    required this.status,
    required this.timestamp,
    this.memo,
    this.hash,
    this.fee,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      fromAddress: json['fromAddress'] as String,
      toAddress: json['toAddress'] as String,
      amount: json['amount'] as int,
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.send,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatus.pending,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      memo: json['memo'] as String?,
      hash: json['hash'] as String?,
      fee: json['fee'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromAddress': fromAddress,
      'toAddress': toAddress,
      'amount': amount,
      'type': type.name,
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
      'memo': memo,
      'hash': hash,
      'fee': fee,
    };
  }

  Transaction copyWith({
    String? id,
    String? fromAddress,
    String? toAddress,
    int? amount,
    TransactionType? type,
    TransactionStatus? status,
    DateTime? timestamp,
    String? memo,
    String? hash,
    int? fee,
  }) {
    return Transaction(
      id: id ?? this.id,
      fromAddress: fromAddress ?? this.fromAddress,
      toAddress: toAddress ?? this.toAddress,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      memo: memo ?? this.memo,
      hash: hash ?? this.hash,
      fee: fee ?? this.fee,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Transaction &&
        other.id == id &&
        other.fromAddress == fromAddress &&
        other.toAddress == toAddress &&
        other.amount == amount &&
        other.type == type &&
        other.status == status &&
        other.timestamp == timestamp &&
        other.memo == memo &&
        other.hash == hash &&
        other.fee == fee;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fromAddress.hashCode ^
        toAddress.hashCode ^
        amount.hashCode ^
        type.hashCode ^
        status.hashCode ^
        timestamp.hashCode ^
        memo.hashCode ^
        hash.hashCode ^
        fee.hashCode;
  }

  @override
  String toString() {
    return 'Transaction(id: $id, fromAddress: $fromAddress, toAddress: $toAddress, amount: $amount, type: $type, status: $status, timestamp: $timestamp, memo: $memo, hash: $hash, fee: $fee)';
  }
}

import 'package:equatable/equatable.dart';

sealed class Result<T> extends Equatable {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => isSuccess ? (this as Success<T>).data : null;
  String? get error => isFailure ? (this as Failure<T>).message : null;

  @override
  List<Object?> get props => [];
}

class Success<T> extends Result<T> {
  @override
  final T data;

  const Success(this.data);

  @override
  List<Object?> get props => [data];

  @override
  String toString() => 'Success(data: $data)';
}

class Failure<T> extends Result<T> {
  final String message;
  final String? code;
  final dynamic details;

  const Failure(this.message, {this.code, this.details});

  @override
  List<Object?> get props => [message, code, details];

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

extension ResultExtensions<T> on Result<T> {
  Result<R> map<R>(R Function(T data) transform) {
    return when(
      success: (data) => Success(transform(data)),
      failure: (message, code, details) =>
          Failure(message, code: code, details: details),
    );
  }

  Result<T> onSuccess(void Function(T data) callback) {
    if (isSuccess) {
      callback(data as T);
    }
    return this;
  }

  Result<T> onFailure(
    void Function(String message, String? code, dynamic details) callback,
  ) {
    if (isFailure) {
      final failure = this as Failure<T>;
      callback(failure.message, failure.code, failure.details);
    }
    return this;
  }

  T? getOrNull() => isSuccess ? data : null;

  T getOrElse(T Function() defaultValue) => isSuccess ? data! : defaultValue();

  T getOrThrow() {
    if (isSuccess) return data!;
    throw Exception(error ?? 'Unknown error occurred');
  }
}

extension ResultWhen<T> on Result<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, String? code, dynamic details) failure,
  }) {
    if (isSuccess) {
      return success(data as T);
    } else {
      final failureResult = this as Failure<T>;
      return failure(
        failureResult.message,
        failureResult.code,
        failureResult.details,
      );
    }
  }
}

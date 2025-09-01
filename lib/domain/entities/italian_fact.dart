import 'package:freezed_annotation/freezed_annotation.dart';

part 'italian_fact.freezed.dart';
part 'italian_fact.g.dart';

@freezed
class ItalianFact with _$ItalianFact {
  const factory ItalianFact({
    required String topic,
    required String description,
    required String date,
    required String message,
    String? url,
  }) = _ItalianFact;

  factory ItalianFact.fromJson(Map<String, dynamic> json) =>
      _$ItalianFactFromJson(json);
}

@freezed
class ItalianFacts with _$ItalianFacts {
  const factory ItalianFacts({required List<ItalianFact> facts}) =
      _ItalianFacts;

  factory ItalianFacts.fromJson(Map<String, dynamic> json) =>
      _$ItalianFactsFromJson(json);
}



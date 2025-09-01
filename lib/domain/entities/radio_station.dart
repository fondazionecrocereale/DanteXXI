import 'package:freezed_annotation/freezed_annotation.dart';

part 'radio_station.freezed.dart';
part 'radio_station.g.dart';

@freezed
class RadioStation with _$RadioStation {
  const factory RadioStation({
    required int id,
    required String name,
    required String streamUrl,
    required String description,
    required String category,
    required String logo,
    @Default(false) bool isPlaying,
  }) = _RadioStation;

  factory RadioStation.fromJson(Map<String, dynamic> json) =>
      _$RadioStationFromJson(json);
}

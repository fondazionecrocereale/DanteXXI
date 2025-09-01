import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/radio_station.dart';

part 'radio_state.freezed.dart';

@freezed
class RadioState with _$RadioState {
  const factory RadioState.initial() = RadioInitial;
  const factory RadioState.loading() = RadioLoading;
  const factory RadioState.loaded({
    required List<RadioStation> stations,
    RadioStation? currentStation,
    @Default(false) bool isPlaying,
    @Default(1.0) double volume,
  }) = RadioLoaded;
  const factory RadioState.error(String message) = RadioError;
}

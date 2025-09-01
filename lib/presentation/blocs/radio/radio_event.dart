import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/radio_station.dart';

part 'radio_event.freezed.dart';

@freezed
class RadioEvent with _$RadioEvent {
  const factory RadioEvent.loadStations() = LoadStations;
  const factory RadioEvent.playStation(RadioStation station) = PlayStation;
  const factory RadioEvent.pauseStation() = PauseStation;
  const factory RadioEvent.stopStation() = StopStation;
  const factory RadioEvent.setVolume(double volume) = SetVolume;
}

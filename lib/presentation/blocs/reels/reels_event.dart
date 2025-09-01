import 'package:equatable/equatable.dart';

abstract class ReelsEvent extends Equatable {
  const ReelsEvent();

  @override
  List<Object?> get props => [];
}

class LoadReels extends ReelsEvent {
  const LoadReels();
}

class RefreshReels extends ReelsEvent {
  const RefreshReels();
}

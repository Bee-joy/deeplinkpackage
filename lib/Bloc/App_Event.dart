import 'package:equatable/equatable.dart';

abstract class Event extends Equatable {
  const Event();
}

class LoadEvent extends Event {
  @override
  List<Object?> get props => throw UnimplementedError();
}

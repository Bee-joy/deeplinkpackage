import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class Event extends Equatable {
  const Event();
  @override
  List<Object?> get props => [];
}

class LoadEvent extends Event {
  final String email;
  final String password;
  const LoadEvent(this.email, this.password);
}

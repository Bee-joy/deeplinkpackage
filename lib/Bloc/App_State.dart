import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AppState extends Equatable {}

class InitialState extends AppState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends AppState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends AppState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends AppState {
  @override
  ErrorState(this.error);
  final String error;
  List<Object?> get props => [error];
}

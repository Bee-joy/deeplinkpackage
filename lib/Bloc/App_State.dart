import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AppState extends Equatable {}

class InitialState extends AppState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends AppState {
  LoadingState(this.loginFrom);
  final String loginFrom;
  @override
  List<Object?> get props => [loginFrom];
}

class LoadedState extends AppState {
  LoadedState(this.login);
  final bool login;

  @override
  List<Object?> get props => [login];
}

class ErrorState extends AppState {
  @override
  ErrorState(this.error);
  final String error;
  List<Object?> get props => [error];
}

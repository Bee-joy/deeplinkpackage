import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginState extends Equatable {}

class InitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoadingLoginState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoadedLoginState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  @override
  LoginErrorState(this.error);
  final String error;
  List<Object?> get props => [error];
}

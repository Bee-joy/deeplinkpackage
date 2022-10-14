import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class Event extends Equatable {
  const Event();
  @override
  List<Object?> get props => [];
}

class LoginEvent extends Event {
  final String email;
  final String password;
  const LoginEvent(this.email, this.password);
}

class RegisterEvent extends Event {
  String username;
  String email;
  String password;
  String referalCode;
  RegisterEvent(this.username, this.email, this.password, this.referalCode);
}

class GoogleLogin extends Event {
  const GoogleLogin();
}

class GoogleLogOut extends Event {
  BuildContext context;
  GoogleLogOut(this.context);
}

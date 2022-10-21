import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Login/Login.dart';
import 'package:deeplink/Onboarding/LoginOption.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<Event, AppState> {
  final Repository _repository;
  LoginBloc(this._repository) : super(InitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoadingState("login"));
      try {
        final users = await _repository.login(event.email, event.password);
        emit(LoadedState(false));
      } catch (e) {
        emit(ErrorState(e.toString()));
        print(e);
      }
    });
    on<GoogleLogin>((event, emit) async {
      emit(LoadingState("google"));
      try {
        final users = await _repository.googleLogin();
        emit(LoadedState(true));
      } catch (e) {
        emit(ErrorState(e.toString()));
        print(e);
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(LoadingState("register"));
      try {
        final users = await _repository.registerUser(
            event.username, event.email, event.password, event.referalCode);
        emit(LoadedState(false));
      } catch (e) {
        emit(ErrorState(e.toString()));
        print(e);
      }
    });
    on<GoogleLogOut>((event, emit) async {
      try {
        final users = await _repository.googleLogOut();
        Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => const LoginOption()));
      } catch (e) {
        emit(ErrorState(e.toString()));
        print(e);
      }
    });
  }
}

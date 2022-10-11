import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<Event, State> {
  final Repository _repository;
  LoginBloc(this._repository) : super(LoadingState()) {
    on<Event>((event, emit) async {
      emit(LoadingState());
    });
  }
}

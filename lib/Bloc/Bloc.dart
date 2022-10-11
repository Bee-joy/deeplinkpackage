import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:deeplink/Repository/RepositoryImpl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocs extends Bloc<Event, LoginState> {
  final RepositoryImpl _repository;
  LoginBlocs(this._repository) : super(InitialState()) {
    on<LoadEvent>((event, emit) async {
      emit(LoadingLoginState());
      try {
        final users = await _repository.login(event.email, event.password);
        LoadedLoginState();
      } catch (e) {
        emit(LoginErrorState(e.toString()));
        print(e);
      }
    });
  }
}

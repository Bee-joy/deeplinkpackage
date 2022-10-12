import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<Event, AppState> {
  final Repository _repository;
  LoginBloc(this._repository) : super(InitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final users = await _repository.login(event.email, event.password);
        emit(LoadedState());
      } catch (e) {
        emit(ErrorState(e.toString()));
        print(e);
      }
    });
  }
}

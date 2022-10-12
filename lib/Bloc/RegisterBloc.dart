import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<Event, AppState> {
  final Repository _repository;
  RegisterBloc(this._repository) : super(InitialState()) {
    on<RegisterEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final users = await _repository.registerUser(
            event.username, event.email, event.password, event.referalCode);
        emit(LoadedState());
      } catch (e) {
        emit(ErrorState(e.toString()));
        print(e);
      }
    });
  }
}

import 'package:equatable/equatable.dart';

abstract class State extends Equatable {}

class LoadingState extends State {
  @override
  List<Object?> get props => throw UnimplementedError();
}

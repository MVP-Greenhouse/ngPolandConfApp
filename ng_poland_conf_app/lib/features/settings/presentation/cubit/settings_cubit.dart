import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.dart';
part 'connection_cubit.freezed.dart';

class ConnectionCubit extends Cubit<ConnectionState> {
  ConnectionCubit() : super(ConnectionState.initial());
}

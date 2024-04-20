import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_set_event.dart';

class CreateSetBloc extends Bloc<CreateSetEvent, bool> {
  CreateSetBloc() : super(false) {
    on<CreateSetEvent>((event, emit) {
      emit(!state);
    });
  }
}

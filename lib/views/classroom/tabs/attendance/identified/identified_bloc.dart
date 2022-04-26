import 'package:attendance_app/views/classroom/tabs/attendance/identified/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Dùng để show dialog nhận diện thông tin người cho tab điểm danh

class IdentifiedBloc extends Bloc<IdentifiedEvent, IdentifiedState> {
  @override
  // TODO: implement initialState
  IdentifiedState get initialState => InitIdentified();

  @override
  Stream<IdentifiedState> mapEventToState(IdentifiedEvent event) async* {
    // TODO: implement mapEventToState
    if (event is Identified) {
      if (state is IdentifiedSuccess) {
        yield (state as IdentifiedSuccess).copyWith(person: event.person);
      } else {
        yield IdentifiedSuccess(person: event.person, isChange: true);
      }
    }
  }
}

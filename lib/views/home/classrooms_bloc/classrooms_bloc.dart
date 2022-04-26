import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/provider/local/persons_local_provider.dart';
import 'package:attendance_app/views/home/classrooms_bloc/classrooms_state.dart';
import 'package:attendance_app/views/home/classrooms_bloc/classrooms_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassroomsBloc extends Bloc<ClassroomsEvent, ClassroomsState> {
  final PersonLocalProvider personLocalProvider;

  ClassroomsBloc(this.personLocalProvider);

  @override
  // TODO: implement initialState
  ClassroomsState get initialState => LoadingClassrooms();

//  @override
//  Stream<Transition<ClassroomsEvent, ClassroomsState>> transformEvents(
//      Stream<ClassroomsEvent> events, transitionFn) {
//    // TODO: implement transformEvents
//    return super.transformEvents(
//        events.debounceTime(const Duration(milliseconds: 2000)), transitionFn);
//  }

  @override
  Stream<ClassroomsState> mapEventToState(ClassroomsEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchClassrooms) {
      yield LoadingClassrooms();
      Persons persons;

      persons = await personLocalProvider.getPersonsFromLocal();

      if (persons == null) {
        persons = Persons.fromJson(jsonPersons);
        final result = await personLocalProvider.savePersonsToLocal(persons);
      }

      final appSensors = AppSensors.fromJson(jsonSensors);
      final devices = Devices.fromJson(jsonDevices);
      final remote = Remote.fromJson(jsonRemote);

      final classrooms = [
        Classroom(
            id: '1',
            name: 'Phòng 1',
            address: 'TA1',
            appSensors: appSensors,
            devices: devices,
            remote: remote,
            persons: persons),
        Classroom(
          id: '2',
          name: 'Phòng 2',
          address: 'TA4',
        ),
      ];
      yield LoadedClassrooms(classrooms: classrooms);
    }
  }
}

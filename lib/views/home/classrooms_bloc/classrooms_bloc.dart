import 'package:do_an_at140225/model/models.dart';
import 'package:do_an_at140225/views/home/classrooms_bloc/classrooms_state.dart';
import 'package:do_an_at140225/views/home/classrooms_bloc/classrooms_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassroomsBloc extends Bloc<ClassroomsEvent, ClassroomsState> {
  @override
  ClassroomsState get initialState => LoadingClassrooms();

  @override
  Stream<ClassroomsState> mapEventToState(ClassroomsEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchClassrooms) {
      yield LoadingClassrooms();

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
            remote: remote),
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

import 'dart:convert';

import 'package:attendance_app/bloc/update_data_bloc/bloc.dart';
import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/provider/local/persons_local_provider.dart';
import 'package:attendance_app/provider/mqtt/mqtt_service.dart';
import 'package:attendance_app/provider/singletons/get_it.dart';
import 'package:attendance_app/views/classroom/tabs/attendance/identified/bloc.dart';
import 'package:attendance_app/views/classroom/tabs/attendance/identified/identified_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class UpdateDataBloc extends Bloc<UpdateDataEvent, UpdateDataState> {
  final _mqttService = locator<MQTTService>();

  UpdateDataBloc(this._identifiedBloc, this.personLocalProvider);

  final IdentifiedBloc _identifiedBloc;
  final PersonLocalProvider personLocalProvider;

  IdentifiedBloc get identifiedBloc => _identifiedBloc;

  @override
  // TODO: implement initialState
  UpdateDataState get initialState => LoadingData();

  @override
  Stream<Transition<UpdateDataEvent, UpdateDataState>> transformEvents(
      Stream<UpdateDataEvent> events, transitionFn) {
    // TODO: implement transformEvents
    return events
        .debounceTime(const Duration(milliseconds: 100))
        .switchMap((transitionFn));
  }

  @override
  Stream<UpdateDataState> mapEventToState(UpdateDataEvent event) async* {
    // TODO: implement mapEventToState
    if (event is InitData) {
      yield LoadedData(classrooms: event.classrooms);
    } else if (event is UpdateData) {
      yield* _updateData(event);
    } else if (event is RemoteDevice) {
      yield* _sendMessage(event);
    }
  }

  Stream<UpdateDataState> _updateData(UpdateData event) async* {
    // yield LoadingState();
    final currentState = state;
    if (currentState is LoadedData) {
      try {
        final mess = event.message.mess;
        if (mess != null && mess.isNotEmpty) {
          final classroom =
              currentState.classrooms[0]; // todo: index of classroom changed
          final topic = event.message.topic;
          if (topic == classroom.appSensors.topicString) {
            // if param sensor changed
            final param = Param.fromJson(jsonDecode(event.message.plainText));
            classroom.appSensors.paramsSensor.add(param);
          } else if (topic == classroom.devices.topicString) {
            // if status devices changed
            classroom.devices.setDevices(event.message.mess);
          } else if (topic == classroom.remote.topicString) {
            // if remote devices changed
            classroom.devices
                .setDevicesFromRemoteTopic(event.message.plainText);
          } else if (topic == classroom.persons.topicString) {
            final data = event.message.mess;
            // identifier for sleeping
            if (data.contains('sleep')) {
              classroom.haveSleep = true;
              yield ShowDialogDataState();
            } else {
              // identifier for attendance
              final arr =
                  event.message.mess.split('_'); // DT010132_20/20/30/18/4/2020
              print(arr.toString());
              if (arr.length == 4) {
                // arr [0]  = DAO
                // [1] = CAM
                // [2] = ANH
                // arr[3] = 20/20/30/18/4/2020;
                final nameId = StringBuffer();
                nameId.write(arr[0] + "_");
                nameId.write(arr[1] + "_");
                nameId.write(arr[2]);

                final indexOfPerson = classroom.persons.persons
                    .indexWhere((p) => p.id == nameId.toString());

                // indexOfPerson = -1 là người không có trong danh sách
                if (indexOfPerson >= 0) {
                  // nhận diện person (hiển thị dialog)
                  _identifiedBloc.add(Identified(
                      person: classroom.persons.persons[indexOfPerson]));

                  // Nếu chưa điểm danh thì mới điểm danh
                  // Điểm danh rồi thì hiển thị dialog
//                if (!classroom.persons.persons[indexOfPerson].isAttendance) {
                  classroom.persons.persons[indexOfPerson].attended(
                      Attendance(arr[3], 1)); // thêm log điểm danh mới
                  classroom.persons.sortPerson(); // sắp xếp lại danh sách
                  final result = await personLocalProvider
                      .savePersonsToLocal(classroom.persons);
//                }
                }
              }
            }
          }
          final List<Classroom> update = List.from(currentState.classrooms)
            ..[0] = classroom;
          yield currentState.copyWith(classrooms: update);
        }
      } catch (e) {
        print(e);
        yield FailedData();
      }
    }
  }

  Stream<UpdateDataState> _sendMessage(RemoteDevice event) async* {
    try {
      _mqttService.sendMessage(event.message);
      if (event.message.mess.contains('bat') ||
          event.message.mess.contains('tat'))
        yield* _mapToUpdateDataState(event.message);
    } catch (e) {
      debugPrint(">>> error: $e");
      yield FailedData(error: e);
    }
  }

  Stream<UpdateDataState> _mapToUpdateDataState(Message message) async* {
    final currentState = state;
    if (currentState is LoadedData) {
      try {
        final mess = message.mess;
        final classroom =
            currentState.classrooms[0]; // todo: index of classroom changed

        String nameDevice =
            'tb${mess[mess.length - 1]}'; // lấy index của thiết bị trong msg
        String newMess = '';

        for (int i = 0; i < classroom.devices.devices.length; i++) {
          if (classroom.devices.devices[i].name == nameDevice) {
            newMess =
                '$newMess$nameDevice:${classroom.devices.devices[i].status == 1 ? 0 : 1}';
          } else {
            newMess = '$newMess${classroom.devices.devices[i].toMess()}';
          }
          if (i < classroom.devices.devices.length - 1) {
            newMess = '$newMess/';
          }
        }
        message.mess = newMess;
        message.topic = classroom.devices.topicString;

        // if status devices changed
        classroom.devices.setDevices(message.mess);
        final List<Classroom> update = List.from(currentState.classrooms)
          ..[0] = classroom;
        yield currentState.copyWith(classrooms: update);
      } catch (e) {
        debugPrint(">>> error: $e");
        yield FailedData(error: e);
      }
    }
  }
}

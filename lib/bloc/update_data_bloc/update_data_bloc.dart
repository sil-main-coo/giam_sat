import 'dart:convert';

import 'package:do_an_at140225/bloc/update_data_bloc/bloc.dart';
import 'package:do_an_at140225/model/models.dart';
import 'package:do_an_at140225/provider/mqtt/mqtt_service.dart';
import 'package:do_an_at140225/provider/singletons/get_it.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class UpdateDataBloc extends Bloc<UpdateDataEvent, UpdateDataState> {
  final _mqttService = locator<MQTTService>();

  @override
  UpdateDataState get initialState => LoadingData();

  @override
  Stream<Transition<UpdateDataEvent, UpdateDataState>> transformEvents(
      Stream<UpdateDataEvent> events, transitionFn) {
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
          }

          final List<Classroom> update = List.from(currentState.classrooms)
            ..[0] = classroom;
          yield currentState.copyWith(classrooms: update);
        }
      } catch (e) {
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

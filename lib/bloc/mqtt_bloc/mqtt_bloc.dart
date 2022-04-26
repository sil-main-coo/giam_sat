import 'package:attendance_app/bloc/mqtt_bloc/bloc.dart';
import 'package:attendance_app/bloc/update_data_bloc/bloc.dart';
import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/provider/mqtt/mqtt_service.dart';
import 'package:attendance_app/provider/singletons/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MQTTBloc extends Bloc<MQTTEvent, MQTTState> {
  final _mqttService = locator<MQTTService>();

  final UpdateDataBloc _updateDataBloc;

  MQTTBloc(this._updateDataBloc);

  @override
  // TODO: implement initialState
  MQTTState get initialState => LoadingState();

  @override
  Stream<MQTTState> mapEventToState(MQTTEvent event) async* {
    if (event is ConnectMQTTService) {
      yield* _connectMQTT(event);
    } else if (event is DisconnectMQTTT) {
      _mqttService.disconnectMQTT();
//      yield DisconnectedMQTT();
    }
  }

  Stream<MQTTState> _connectMQTT(ConnectMQTTService event) async* {
    yield LoadingState();
    _mqttService.initMQTT();
    try {
      final result = await _mqttService.connectMQTT();
      if (result.state == MqttConnectionState.connecting) {
        yield LoadingState();
      } else if (result.state == MqttConnectionState.connected) {
        // subscribe topics of classrooms
        final classroom = event.classrooms[0];

        _mqttService.client.subscribe(
            classroom.appSensors.topicString, classroom.appSensors.qos);
        _mqttService.client.subscribe(
            classroom.remote.topicString, classroom.appSensors.qos);
//        _mqttService.client
//            .subscribe(classroom.devices.topicString, classroom.devices.qos);
//         _mqttService.client
//             .subscribe(classroom.persons.topicString, classroom.persons.qos);

        // listen data change
        _mqttService.client.updates
            .listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final MqttPublishMessage recMess = c[0].payload;
          final pt =
              MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

          debugPrint(
              '>>> Change notification - topic: <${c[0].topic}>, payload: <-- $pt -->');

          // update message to classroom
          _updateDataBloc.add(UpdateData(
              message: Message(
                  topic: c[0].topic, mess: pt, qos: c[0].payload.header.qos)));
        });
        _updateDataBloc.add(InitData(
            classrooms: event.classrooms)); // khởi tạo data vào update data
        yield ConnectedMQTT(); // thông báo connect thành công
      } else {
        debugPrint(
            'Client exception, status is ${_mqttService.client.connectionStatus}');
        _mqttService.disconnectMQTT();
        yield ErrorState();
      }
    } on Exception catch (e) {
      debugPrint('Client exception - $e');
      _mqttService.disconnectMQTT();
      yield ErrorState();
    }
  }
}

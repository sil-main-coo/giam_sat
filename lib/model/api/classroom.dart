import 'package:equatable/equatable.dart';
import 'api.dart';

final jsonSensors = {
  'topic_string': 'node_AT140225_data',
  'qos': 1,
  'params': [
    {'temp': '30.00', 'qos': 1, 'hum': '44.4', 'gas': '12.2', 'lux': '469'}
  ],
};

final jsonOffline = {
  'topic_string': 'node_AT140225_offline',
  'qos': 1,
  'params': [
    {'qos': 1, 'temp': 30.2, 'hum': 44.4, 'smoke': 12.2}
  ],
};

final jsonDevices = {
  'topic_string': 'node_dt010133_stt',
  'qos': 1,
  'devices': [
    {'label': 'Đèn', 'name': 'tb1', 'status': 0},
    {'label': 'Quạt', 'name': 'tb2', 'status': 0}
  ],
};

final jsonRemote = {
  'topic_string': 'node_AT140225_remote',
  'qos': 1,
};


class Classroom extends Equatable {
  final String id, name, address;
  final AppSensors appSensors;
  final Remote remote;
  final Devices devices;
  bool haveSleep;

  Classroom(
      {this.id,
      this.name,
      this.address,
      this.appSensors,
      this.devices,
      this.haveSleep = false,
      this.remote});

  @override
  List<Object> get props =>
      [id, name, address, appSensors, remote, devices, haveSleep];

  @override
  bool get stringify => true;
}

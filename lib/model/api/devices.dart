import 'package:do_an_at140225/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Devices extends AppTopic with EquatableMixin {
  List<Device> _devices;

  Devices(String topicString, MqttQos qos, this._devices)
      : super(topicString: topicString, qos: qos);

  List<Device> get devices => _devices;

  Devices.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    final devices = json['devices'];
    if (devices != null) {
      _devices = List();
      for (dynamic d in devices) {
        _devices.add(Device.fromJson(d));
      }
    }
  }

  void setDevicesFromRemoteTopic(String command){
    switch(command){
      case 'on1':
        devices[0].setStatusInt(1);
        return;
      case 'off1':
        devices[0].setStatusInt(0);
        return;
      case 'on2':
        devices[1].setStatusInt(1);
        return;
      case 'off2':
        devices[1].setStatusInt(0);
        return;
    }
  }

  // set status device from topic mess
  void setDevices(String mess) {
    final arr = mess.split('/');
    print('${arr.toString()}');
    if (arr.length >= _devices.length) {
      for (int i = 0; i < arr.length; i++) {
        _devices[i].setStatus(arr[i]);
      }
    } else {
      for (int i = 0; i < _devices.length; i++) {
        if (i < arr.length) {
          _devices[i].setStatus(arr[i]);
        } else {
          _devices[i]._status = null;
        }
      }
    }
  }

  @override
  List<Object> get props => [devices];
}

class Device extends Equatable {
  String _label;
  String _name;
  int _status;
  MqttQos _qos;

  Device(this._label, this._status, this._qos);

  Device.fromJson(Map<String, dynamic> json) {
    _label = json['label'];
    _name = json['name'];
    _status = json['status'];
  }

  void setStatus(String data) {
    final arr = data.split(':');
    _name = arr[0];
    _status = int.parse(arr[1]);
  }

  void setStatusInt(int status){
    _status = status;
  }

  String toMess() => '$name:$status';

  int get status => _status;

  String get name => _name;

  String get label => _label;

  @override
  List<Object> get props => [label, name, status, qos];

  MqttQos get qos => _qos;
}

import 'package:attendance_app/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_client/mqtt_client.dart';

class AppSensors extends AppTopic with EquatableMixin{
  List<Param> _paramsSensor;

  AppSensors(String topicString, MqttQos qos, this._paramsSensor)
      : super(topicString: topicString, qos: qos);

  AppSensors.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    final data = json['params'];
    _paramsSensor = List();
    data.forEach((f) {
      _paramsSensor.add(Param.fromJson(f));
    });
  }

  List<Param> get paramsSensor => _paramsSensor;

  @override
  // TODO: implement props
  List<Object> get props => [paramsSensor];
}

class Param extends Equatable{
  double _temp, _hum, _gas, _lux;
  int _person;
  String _time;
  MqttQos _qos;

  Param.fromJson(Map<String, dynamic> json) {
    _time = json['time'];
    switch(json['qos']){
      case 1:
        _qos = MqttQos.atLeastOnce;
        break;
      case 2:
        _qos = MqttQos.exactlyOnce;
        break;
      case 3:
        _qos = MqttQos.atMostOnce;
        break;
      default:
        _qos = MqttQos.atLeastOnce;
    }
    _temp = double.parse(json['temp']);
    _hum = double.parse(json['hum']);
    _gas = double.parse(json['gas']);
    _lux = double.parse(json['lux']);
    //_person = json['persons'];
  }

  int get person => _person;

  get gas => _gas;

  get hum => _hum;

  get lux => _lux;

  double get temp => _temp;

  String get time => _time;

  MqttQos get qos => _qos;

  @override
  // TODO: implement props
  List<Object> get props => [ _temp, _hum, _gas, _person, _time, _qos, _lux];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}

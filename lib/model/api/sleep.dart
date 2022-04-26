//
//import 'package:equatable/equatable.dart';
//import 'package:mqtt_client/mqtt_client.dart';
//import 'package:attendance_app/model/models.dart';
//
//
//class Sleep extends AppTopic with EquatableMixin{
//  bool _isSleep;
//
//  Sleep(String topicString, MqttQos qos, this._isSleep)
//      : super(topicString: topicString, qos: qos);
//
//
//  bool get isSleep => _isSleep;
//
//  Sleep.fromJson(Map<String, dynamic> json) : super.fromJson(json){
//    _isSleep = json['sleep'] ?? false;
//  }
//
//  // set status device from topic mess
//  set setSleep(bool isSleep) {
//    _isSleep = isSleep;
//  }
//
//  @override
//  // TODO: implement props
//  List<Object> get props => [_isSleep];
//
//}
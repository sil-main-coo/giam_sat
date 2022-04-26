import 'package:attendance_app/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Remote extends AppTopic with EquatableMixin{
  String mess;

  Remote(String topic, this.mess, MqttQos qos)
      : super(topicString: topic, qos: qos);

  Remote.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  // TODO: implement props
  List<Object> get props => [mess];
}

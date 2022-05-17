import 'package:do_an_at140225/configs/encrypt/aes.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Message extends Equatable {
  String mess;
  String topic;
  MqttQos qos;

  String get plainText => AESUtils.decrypt(mess);

  Message({
    this.mess,
    this.topic,
    this.qos,
  });

  @override
  List<Object> get props => [topic, qos, mess];

  @override
  bool get stringify => true;
}

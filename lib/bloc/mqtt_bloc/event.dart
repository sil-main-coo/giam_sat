import 'package:attendance_app/model/models.dart';
import 'package:equatable/equatable.dart';

abstract class MQTTEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

//class InitMQTTService extends MQTTEvent{}

class DisconnectMQTTT extends MQTTEvent{}

class ConnectMQTTService extends MQTTEvent{
  final List<Classroom> classrooms;

  ConnectMQTTService({this.classrooms = const []});

  @override
  // TODO: implement props
  List<Object> get props => [classrooms];

}

class SendMessage extends MQTTEvent{
  final Message message;

  SendMessage({this.message}) : assert(message!=null);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
import 'package:attendance_app/model/api/api.dart';
import 'package:equatable/equatable.dart';

class IdentifiedEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CloseDialogInfo extends IdentifiedEvent{}

class Identified extends IdentifiedEvent {
  final Person person;

  Identified({this.person}) : assert(person!=null);

  @override
  // TODO: implement props
  List<Object> get props => [person];
}
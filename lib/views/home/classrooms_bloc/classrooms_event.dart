import 'package:do_an_at140225/model/models.dart';
import 'package:equatable/equatable.dart';

class ClassroomsEvent extends Equatable{
  const ClassroomsEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchClassrooms extends ClassroomsEvent{}


class TimerTicked extends ClassroomsEvent{}

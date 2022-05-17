import 'package:do_an_at140225/model/api/api.dart';
import 'package:do_an_at140225/model/mqtt/message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UpdateDataEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitData extends UpdateDataEvent{
  final List<Classroom> classrooms;

  InitData({this.classrooms = const []});

  @override
  // TODO: implement props
  List<Object> get props => [classrooms];
}

class UpdateData extends UpdateDataEvent{
  final Message message;

  UpdateData({this.message}) : assert (message!=null);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class RemoteDevice extends UpdateDataEvent{
  final Message message;

  RemoteDevice({@required this.message}) : assert(message!=null);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
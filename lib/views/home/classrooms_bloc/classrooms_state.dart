import 'package:attendance_app/model/api/classroom.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ClassroomsState extends Equatable{
  const ClassroomsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingClassrooms extends ClassroomsState{}

class ConnectingClassrooms extends ClassroomsState{}

class LoadedClassrooms extends ClassroomsState{
  final List<Classroom> classrooms;

  LoadedClassrooms({this.classrooms = const []});

  @override
  // TODO: implement props
  List<Object> get props => [classrooms];
}

class FailedClassrooms extends ClassroomsState{
  final String error;

  FailedClassrooms({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Classrooms Failure { error: $error }';
}
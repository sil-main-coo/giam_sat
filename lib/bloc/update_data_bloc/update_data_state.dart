import 'package:do_an_at140225/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UpdateDataState extends Equatable {
  const UpdateDataState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingData extends UpdateDataState {}

class LoadedData extends UpdateDataState {
  final List<Classroom> classrooms;
  final bool isChange;

  const LoadedData({this.classrooms = const [], this.isChange = true});

  LoadedData copyWith({
    List<Classroom> classrooms,
  }) {
    return LoadedData(
        classrooms: classrooms ?? this.classrooms, isChange: !this.isChange);
  }

  @override
  List<Object> get props => [classrooms, isChange];
}

class FailedData extends UpdateDataState {
  final Exception error;

  FailedData({ this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FailedData { error: $error }';
}

class RemoteSuccess extends UpdateDataState {}

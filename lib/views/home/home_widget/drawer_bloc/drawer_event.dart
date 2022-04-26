import 'package:equatable/equatable.dart';

abstract class DrawerEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DrawerMenuClicked extends DrawerEvent{
  final int index;

  DrawerMenuClicked(this.index);

  @override
  // TODO: implement props
  List<Object> get props => [index];
}
import 'package:equatable/equatable.dart';

abstract class DrawerState extends Equatable{
  const DrawerState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitDrawer extends DrawerState{}

class IndexDrawerClicked extends DrawerState{
  final int index;

  IndexDrawerClicked(this.index);

  @override
  // TODO: implement props
  List<Object> get props => [index];
}
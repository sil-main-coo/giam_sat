import 'package:attendance_app/views/home/home_widget/drawer_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState>{
  @override
  // TODO: implement initialState
  DrawerState get initialState => InitDrawer();

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async*{
    if(event is DrawerMenuClicked){
      // Drawer clicked
      yield IndexDrawerClicked(event.index);
    }
  }
}
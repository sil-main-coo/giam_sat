import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/configs/values/font_size.dart';
import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/views/home/home_widget/drawer_bloc/bloc.dart';
import 'package:attendance_app/views/widgets/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'children/drawer.dart';
import 'fragments/classrooms/classrooms_fragment.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({this.classrooms});

  final List<Classroom> classrooms;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // print('>>> build home widget');
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Trang chủ',
          style: Theme.of(context)
              .primaryTextTheme
              .title
              .copyWith(fontSize: ScreenUtil().setSp(fzTitle)),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.sort,
              color: colorTextWhite,
            ),
            onPressed: () => scaffoldKey.currentState.openDrawer()),
      ),
      drawer: DrawerMenu(),
      body: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is IndexDrawerClicked) {
//            print('>>> REBUID INDEXSTACK');
            return IndexedStack(
              index: state.index,
              children: <Widget>[
                ClassroomsFragment(),
              ],
            );
          }
          return AppLoadingWidget();
        },
      ),
    );
  }
}

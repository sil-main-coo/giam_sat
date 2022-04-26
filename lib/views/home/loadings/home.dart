import 'dart:async';

import 'package:attendance_app/bloc/mqtt_bloc/bloc.dart';
import 'package:attendance_app/bloc/update_data_bloc/bloc.dart';
import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/configs/values/font_size.dart';
import 'package:attendance_app/views/home/classrooms_bloc/bloc.dart';
import 'package:attendance_app/views/router/route_name.dart';
import 'package:attendance_app/views/widgets/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

class InitHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print('>>> build homepage');

    return BlocBuilder<ClassroomsBloc, ClassroomsState>(
      builder: (context, state) {
        if (state is LoadingClassrooms) {
          return Text(
            'Đang tải lớp học...',
            style: Theme.of(context).primaryTextTheme.caption.copyWith(
                fontSize: ScreenUtil().setSp(
                  fzCaption,
                ),
                color: colorTextWhite),
          );
        } else if (state is FailedClassrooms) {
          return AppErrorWidget(
            iconData: Icons.cloud_off,
            mess: 'Đã xảy ra lỗi',
            function: () =>
                BlocProvider.of<ClassroomsBloc>(context).add(FetchClassrooms()),
          );
        } else if (state is LoadedClassrooms) {
          BlocProvider.of<MQTTBloc>(context)
              .add(ConnectMQTTService(classrooms: state.classrooms));
          return ConnectMQTTWidget();
        }

        return null;
      },
    );
  }
}

class ConnectMQTTWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print('>>> build conn');

    return BlocConsumer<MQTTBloc, MQTTState>(
      listener: (context, state) {
        if (state is ConnectedMQTT) {
          Timer(Duration(milliseconds: 1500), () {
            Navigator.pushReplacementNamed(context, RouteName.home);
          });
        }
      },
      builder: (context, state) {
        if (state is ErrorState) {
          return AppErrorWidget(
            iconData: Icons.cloud_off,
            mess: 'Lỗi kết nối',
            function: () =>
                BlocProvider.of<MQTTBloc>(context).add(ConnectMQTTService()),
          );
        } else if (state is DisconnectedMQTT) {
          return AppErrorWidget(
            iconData: Icons.cloud_off,
            mess: 'Đã ngắt kết nối !',
            function: () =>
                BlocProvider.of<MQTTBloc>(context).add(ConnectMQTTService()),
          );
        }

        return Text(
          'Kết nối server...',
          style: Theme.of(context).primaryTextTheme.caption.copyWith(
              fontSize: ScreenUtil().setSp(
                fzCaption,
              ),
              color: colorTextWhite),
        );
      },
    );
  }
}

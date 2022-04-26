import 'package:attendance_app/bloc/update_data_bloc/bloc.dart';
import 'package:attendance_app/configs/values/values.dart';
import 'package:attendance_app/model/api/api.dart';
import 'package:attendance_app/views/classroom/tabs/attendance/attendance_tab.dart';
import 'package:attendance_app/views/widgets/dialogs/dialogs.dart';
import 'package:attendance_app/views/widgets/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'tabs/control/control_device_tab.dart';

class ClassroomPage extends StatelessWidget {
  ClassroomPage({this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateDataBloc, UpdateDataState>(
      listener: (context, state) {
        if (state is ShowDialogDataState) {
          AppDialog.showNotifyDialog(
              context: context,
              mess: 'Có học sinh ngủ gật!',
              title: 'Cảnh báo',
              textBtn: 'OK',
              function: () => Navigator.pop(context),
              color: secondary);
        } else if (state is FailedData) {
          AppDialog.showNotifyDialog(context: context,
              title: 'Lỗi',
              mess: 'Đã xảy ra lỗi. Hãy thử lại',
              textBtn: 'OK',
              function: () => Navigator.pop(context),
              color: secondary);
        }
      },
      builder: (context, state) {
        if (state is LoadedData) {
          return index == 0
              ? _buildBodyRoom1(context, state.classrooms[0])
              : _buildBodyOfRoom2(context, state.classrooms[index],
              state.classrooms[0].persons);
        }
        return AppLoadingWidget(
          mess: 'Xin chờ...',
        );
      },
    );
  }

  _buildBodyOfRoom2(BuildContext context, Classroom classroom,
      Persons persons) {
    final personsOfRoom2 = persons.persons
        .where((element) => element.id == 'TA_MINH_SON')
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${classroom.name}',
            style: Theme
                .of(context)
                .primaryTextTheme
                .title
                .copyWith(fontSize: ScreenUtil().setSp(fzTitle)),
          ),
          iconTheme: IconThemeData(color: colorIconWhite),
        ),
        body: AttendanceTab(
          persons: personsOfRoom2,
          nameRoom: classroom.name,
        ));
  }

  _buildBodyRoom1(BuildContext context, Classroom classroom) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${classroom.name}',
          style: Theme
              .of(context)
              .primaryTextTheme
              .title
              .copyWith(fontSize: ScreenUtil().setSp(fzTitle)),
        ),
        iconTheme: IconThemeData(color: colorIconWhite),
      ),
      body: ControlDeviceTab(
          appSensors: classroom.appSensors,
          devices: classroom.devices,
          remote: classroom.remote),
      // bottomNavigationBar:
    );
  }
}

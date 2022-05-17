import 'package:do_an_at140225/bloc/update_data_bloc/bloc.dart';
import 'package:do_an_at140225/configs/values/values.dart';
import 'package:do_an_at140225/model/api/api.dart';
import 'package:do_an_at140225/views/widgets/dialogs/dialogs.dart';
import 'package:do_an_at140225/views/widgets/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'control/control_device.dart';

class ClassroomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateDataBloc, UpdateDataState>(
      listener: (context, state) {
         if (state is FailedData) {
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
          return _buildBodyRoom(context, state.classrooms[0]);
        }
        return AppLoadingWidget(
          mess: 'Xin chờ...',
        );
      },
    );
  }

  _buildBodyRoom(BuildContext context, Classroom classroom) {
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
      body: ControlDevice(
          appSensors: classroom.appSensors,
          devices: classroom.devices,
          remote: classroom.remote),
    );
  }
}

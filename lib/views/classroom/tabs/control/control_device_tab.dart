import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/configs/values/values.dart';
import 'package:attendance_app/model/api/devices.dart';
import 'package:attendance_app/model/api/remote.dart';
import 'package:attendance_app/model/api/sensors.dart';
import 'package:attendance_app/views/classroom/tabs/control/children/devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'children/param_sensor.dart';

class ControlDeviceTab extends StatefulWidget {
  final AppSensors appSensors;
  final Devices devices;
  final Remote remote;

  ControlDeviceTab({this.appSensors, this.devices, this.remote})
      : assert(appSensors != null || devices != null || remote != null);

  @override
  _ControlDeviceTabState createState() => _ControlDeviceTabState();
}

class _ControlDeviceTabState extends State<ControlDeviceTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ParamSensor(
          sensors: widget.appSensors.paramsSensor,
        ),
        Divider(color: primary,),
        DevicesWidget(
          devices: widget.devices,
          remote: widget.remote,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
       // ControlAttendanceWidget(topicRemote: widget.remote.topicString,)
      ],
    );
  }
}

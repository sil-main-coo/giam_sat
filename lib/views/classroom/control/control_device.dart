import 'package:do_an_at140225/configs/values/colors.dart';
import 'package:do_an_at140225/configs/values/values.dart';
import 'package:do_an_at140225/model/api/devices.dart';
import 'package:do_an_at140225/model/api/remote.dart';
import 'package:do_an_at140225/model/api/sensors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'children/devices.dart';
import 'children/param_sensor.dart';

class ControlDevice extends StatefulWidget {
  final AppSensors appSensors;
  final Devices devices;
  final Remote remote;

  ControlDevice({this.appSensors, this.devices, this.remote})
      : assert(appSensors != null || devices != null || remote != null);

  @override
  _ControlDeviceTabState createState() => _ControlDeviceTabState();
}

class _ControlDeviceTabState extends State<ControlDevice> {
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
      ],
    );
  }
}

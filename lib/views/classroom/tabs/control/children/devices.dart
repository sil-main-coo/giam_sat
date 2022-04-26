import 'package:attendance_app/bloc/update_data_bloc/bloc.dart';
import 'package:attendance_app/configs/encrypt/aes.dart';
import 'package:attendance_app/configs/values/values.dart';
import 'package:attendance_app/model/api/devices.dart';
import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/views/widgets/animations/delay_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';

class DevicesWidget extends StatelessWidget {
  DevicesWidget({this.devices, this.remote}) : assert(devices != null);

  final Devices devices;
  final Remote remote;

  _remoteDevices(BuildContext context, int index, int currentStatus) {
    final action = currentStatus == 1 ? 'off' : 'on';
    final mess = '$action$index\$';

    BlocProvider.of<UpdateDataBloc>(context)
      ..add(RemoteDevice(
          message: Message(
              topic: remote.topicString,
              qos: MqttQos.exactlyOnce,
              mess: AESUtils.encrypt(mess))));
  }

  @override
  Widget build(BuildContext context) {
    final listDevice = devices.devices;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DelayedAnimation(
            delay: 400,
            offset: Offset(0, -0.36),
            child: Text(
              'THIẾT BỊ',
              style: Theme.of(context).primaryTextTheme.title.copyWith(
                  fontSize: ScreenUtil().setSp(fzSubTitle), color: primaryDark),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _deviceItem(
                    context,
                    FontAwesomeIcons.lightbulb,
                    0,
                    listDevice[0].label,
                    listDevice[0].status,
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(20),
                  ),
                  _deviceItem(
                    context,
                    FontAwesomeIcons.fan,
                    1,
                    listDevice[1].label,
                    listDevice[1].status,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  _deviceItem(
    BuildContext context,
    IconData iconData,
    int index,
    String label,
    int status,
  ) {
    final color = status == 1 ? primary : Colors.black54;
    final stt = status == 0 ? 'Đang tắt' : 'Đang bật';

    return SizedBox(
      height: ScreenUtil().setHeight(120),
      width: ScreenUtil().setHeight(140),
      child: RaisedButton(
        onPressed: () => _remoteDevices(context, index + 1, status),
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              iconData,
              color: colorIconWhite,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                  fontSize: ScreenUtil().setSp(fzButton),
                  color: colorTextWhite),
            ),
            Text(stt,
                style: Theme.of(context).primaryTextTheme.caption.copyWith(
                    fontSize: ScreenUtil().setSp(10), color: colorTextWhite))
          ],
        ),
      ),
    );
  }
}

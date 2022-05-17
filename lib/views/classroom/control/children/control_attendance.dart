import 'package:do_an_at140225/bloc/update_data_bloc/bloc.dart';
import 'package:do_an_at140225/configs/values/values.dart';
import 'package:do_an_at140225/model/models.dart';
import 'package:do_an_at140225/views/widgets/animations/delay_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mqtt_client/mqtt_client.dart';

class ControlAttendanceWidget extends StatelessWidget {
  const ControlAttendanceWidget({this.topicRemote})
      : assert(topicRemote != null);

  final String topicRemote;

  _remoteAttendance(BuildContext context, String action) {
    BlocProvider.of<UpdateDataBloc>(context)
      ..add(RemoteDevice(
          message: Message(
              topic: topicRemote, qos: MqttQos.exactlyOnce, mess: action)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DelayedAnimation(
            delay: 500,
            offset: Offset(0, -0.36),
            child: Text(
              'Control Attendance',
              style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                  fontSize: ScreenUtil().setSp(fzSubTitle),
                  color: colorTextWhite),
            )),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ButtonAttendance(
              label: 'START',
              function: () => _remoteAttendance(context, 'start'),
              color: secondary,
              iconData: Icons.camera,
            ),
            // Text('Status: ON', style: Theme.of(context).primaryTextTheme.caption.copyWith(fontSize: ScreenUtil().setSp(fzCaption)),),
            ButtonAttendance(
              label: 'STOP',
              color: colorNoAttend,
              function: () => _remoteAttendance(context, 'stop'),
              iconData: Icons.stop,
            ),
          ],
        )
      ],
    );
  }
}

class ButtonAttendance extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color color;
  final Function function;

  const ButtonAttendance({this.function, this.label, this.iconData, this.color})
      : assert(iconData != null && label != null && function != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(75),
          width: ScreenUtil().setHeight(75),
          child: RaisedButton(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setHeight(90)))),
            child: Icon(
              iconData,
              color: colorIconWhite,
              size: ScreenUtil().setSp(32),
            ),
            color: color ?? transparentWhite56,
            onPressed: function,
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        Text(
          label,
          style: Theme.of(context).primaryTextTheme.headline.copyWith(
              color: colorTextWhite, fontSize: ScreenUtil().setSp(fzTitle)),
        ),
      ],
    );
  }
}

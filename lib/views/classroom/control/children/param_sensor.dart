import 'package:do_an_at140225/configs/values/custom_icon.dart';
import 'package:do_an_at140225/configs/values/values.dart';
import 'package:do_an_at140225/model/api/api.dart';
import 'package:do_an_at140225/views/widgets/animations/delay_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParamSensor extends StatelessWidget {
  ParamSensor({this.sensors});

  final List<Param> sensors;

  @override
  Widget build(BuildContext context) {
    final currentParam = sensors[sensors.length - 1];

    return Container(
      height: ScreenUtil().setHeight(240),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(16),
            horizontal: ScreenUtil().setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DelayedAnimation(
              delay: 200,
              offset: Offset(0, -0.36),
              child: Text(
                'THÔNG SỐ GIÁM SÁT',
                style: Theme.of(context).primaryTextTheme.title.copyWith(
                    fontSize: ScreenUtil().setSp(fzSubTitle),
                    color: primaryDark),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: DelayedAnimation(
                      delay: 300,
                      offset: Offset(-0.36, 0),
                      child: _itemParamSensor(
                          context,
                          CustomIcon.temp,
                          'Nhiệt độ',
                          currentParam.temp.toString(),
                          '°C')),
                ),
                Expanded(
                  flex: 2,
                  child: DelayedAnimation(
                    delay: 300,
                    offset: Offset(0.36, 0),
                    child: _itemParamSensor(context, CustomIcon.water,
                      'Độ ẩm', currentParam.hum.toString(), '%')
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: DelayedAnimation(
                      delay: 300,
                      offset: Offset(-0.36, 0),
                      child: _itemParamSensor(context, CustomIcon.air,
                          'Gas', currentParam.gas.toString(), 'ppm')),
                ),
                Expanded(
                  flex: 2,
                  child: DelayedAnimation(
                      delay: 300,
                      offset: Offset(0.36, 0),
                      child: _itemParamSensor(context, CustomIcon.light,
                          'Ánh sáng', currentParam.lux.toString(), 'lux')
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _itemParamSensor(BuildContext context, IconData icon, String name,
      String param, String measure) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          icon,
          color: primary,
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: Theme.of(context)
                    .primaryTextTheme
                    .body2
                    .copyWith(fontSize: ScreenUtil().setSp(fzBody2), color: primary),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    param,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .subhead
                        .copyWith(fontSize: ScreenUtil().setSp(fzSubHead)),
                  ),
                  Text(
                    measure,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .caption
                        .copyWith(fontSize: ScreenUtil().setSp(fzCaption)),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

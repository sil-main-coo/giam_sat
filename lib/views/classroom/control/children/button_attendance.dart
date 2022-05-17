import 'package:do_an_at140225/configs/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ButtonAttendance extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Icon(
            Icons.play_arrow,
            color: colorIconWhite,
            size: 48,
          ),
          color: transparentWhite56,
          onPressed: ()=> print('turn on'),
        ),
        SizedBox(height: ScreenUtil().setHeight(15),),
        Text(
          'ON',
          style: Theme.of(context)
              .primaryTextTheme
              .headline
              .copyWith(color: colorTextWhite, fontSize: ScreenUtil().setSp(fzTitle)),
        ),
      ],
    );
  }
}

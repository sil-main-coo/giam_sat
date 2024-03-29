import 'package:do_an_at140225/configs/values/colors.dart';
import 'package:do_an_at140225/configs/values/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorWidget extends StatelessWidget {
  final String mess;
  final IconData iconData;
  final Function function;

  const AppErrorWidget({this.mess, this.iconData, this.function})
      : assert(mess != null && iconData != null && function != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          iconData,
          color: secondary,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(8),
        ),
        Text(
          mess.toString(),
          maxLines: 1,
          style: Theme.of(context).primaryTextTheme.title.copyWith(
              fontSize: ScreenUtil().setSp(
                16,
              ),
              color: secondary),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(8),
        ),
        RaisedButton.icon(
          onPressed: function,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          icon: Icon(
            Icons.refresh,
            color: colorIconWhite,
          ),
          color: secondary,
          label: Text(
            'THỬ LẠI',
            style: Theme.of(context).primaryTextTheme.button.copyWith(
                  fontSize: ScreenUtil().setSp(fzButton),
                ),
          ),
        )
      ],
    );
  }
}

import 'package:attendance_app/configs/values/values.dart';
import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/views/widgets/avatar_default.dart';
import 'package:countdown/countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogIdentifiedInfo {
  static bool isDialogShowing = false;

  static void show(BuildContext context, Person person) {
    isDialogShowing = true;
    CountDown cd = CountDown(Duration(seconds: 5));
    var sub = cd.stream.listen(null);

    sub.onDone(() {
      if (isDialogShowing) {
        _closeDialog(context);
      }
    });

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              elevation: 5,
              backgroundColor: bgWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Nhận diện',
                    style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                        fontSize: ScreenUtil().setSp(fzSubTitle),
                        color: colorTextSecondary),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(32),
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(person.avatar),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Text(
                    person.fullName,
                    style: Theme.of(context).primaryTextTheme.title.copyWith(
                        fontSize: ScreenUtil().setSp(fzSubTitle),
                        color: primary),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Text(
                    person.id,
                    style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                        fontSize: ScreenUtil().setSp(fzCaption),
                        color: colorTextBlack),
                  )
                ],
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              actions: <Widget>[
                RaisedButton(
                  color: secondary,
                  onPressed: () async {
                    sub.cancel();
                    _closeDialog(context);
                  },
                  child: Text('Đóng', style: Theme.of(context).primaryTextTheme.button.copyWith(
                      fontSize: ScreenUtil().setSp(fzButton)),),
                )
              ],
            ));
  }

  static void hide(BuildContext context) {
    _closeDialog(context);
  }

  static _closeDialog(BuildContext context) {
    isDialogShowing = false;
    Navigator.of(context).pop(DialogIdentifiedInfo());
  }
}

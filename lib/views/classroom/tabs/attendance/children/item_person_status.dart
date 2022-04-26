import 'dart:async';
import 'dart:ui';
import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/model/api/api.dart';
import 'package:attendance_app/views/router/route_name.dart';
import 'package:attendance_app/views/widgets/avatar_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dialog_info.dart';

class PersonStatusItem extends StatelessWidget {
  const PersonStatusItem({
    this.index,
    this.person,
  });

  final int index;
  final Person person;

  @override
  Widget build(BuildContext context) {
    final currentColor = person.isAttendance ? primaryLight : bgWhite;

    return Container(
      color: currentColor,
      padding: const EdgeInsets.only(
        left: 32,
        top: 16.0,
        bottom: 32,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        onTap: () {
          Navigator.pushNamed(context, RouteName.profile,
              arguments: {'person': person});
//                DialogIdentifiedInfo.show(context, person);
//                if (DialogIdentifiedInfo.isDialogShowing) {
//                  Timer(Duration(seconds: 5), () {
//                    if (DialogIdentifiedInfo.isDialogShowing) {
//                      DialogIdentifiedInfo.hide(context);
//                    }
//                  });
//                }
        },
        leading:
            person.avatar == null ? AvatarDefault() : _avatar(person.avatar),
        title: Text(
          person.fullName,
          style: TextStyle(color: primaryDark, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(person.id, style: TextStyle(color: colorTextBlack)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            person.isAttendance
                ? Icon(
                    Icons.check,
                    color: colorAttended,
                    size: ScreenUtil().setSp(24),
                  )
                : Icon(
                    Icons.close,
                    color: colorNoAttend,
                    size: ScreenUtil().setSp(24),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Visibility(
                  visible: person.isAttendance,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(person.lastAttendance?.dMyString.toString(),
                          style: TextStyle(color: colorTextBlack)),
                      Text(person.lastAttendance?.hourMinuteString.toString(),
                          style: TextStyle(color: colorTextBlack)),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  _avatar(avatar) {
    return CircleAvatar(
      backgroundImage: AssetImage(avatar),
    );
  }
}

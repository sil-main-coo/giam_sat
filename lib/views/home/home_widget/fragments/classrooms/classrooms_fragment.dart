import 'package:do_an_at140225/configs/values/string.dart';
import 'package:do_an_at140225/configs/values/values.dart';
import 'package:do_an_at140225/views/widgets/appbar/appbar_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'gridview_classroom.dart';

class ClassroomsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: ScreenUtil().setWidth(40),
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                Text(
                  'Quản trị trường',
                  style: Theme.of(context).primaryTextTheme.title.copyWith(
                      fontSize: ScreenUtil().setSp(fzSubHead),
                      color: primaryDark),
                ),
                Column(children: [
                  Text(
                    AppValues.schoolName,
                    style: Theme.of(context).primaryTextTheme.title.copyWith(
                        fontSize: ScreenUtil().setSp(fzSubTitle),
                        color: secondary),
                  ),
                  Text(
                    AppValues.schoolYear,
                    style: Theme.of(context).primaryTextTheme.title.copyWith(
                        fontSize: ScreenUtil().setSp(fzSubTitle),
                        color: secondary),
                  )
                ],)
              ],
            ),
          ),
          Divider(
            color: primary,
          ),
          Classrooms(),
        ],
      ),
    );
  }
}

import 'package:attendance_app/configs/values/values.dart';
import 'package:attendance_app/model/api/api.dart';
import 'package:attendance_app/views/router/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemClassroom extends StatelessWidget {
  ItemClassroom({this.index, this.classroom});

  final Classroom classroom;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: () => index == 0
            ? Navigator.pushNamed(context, RouteName.classroom,
                arguments: {'index': index})
            : Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  '${classroom.name} hiện không khả dụng',
                  style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                      fontSize: ScreenUtil().setSp(fzCaption),
                      color: colorTextWhite),
                ),
                duration: Duration(milliseconds: 1000),
                backgroundColor: secondary,
              )),
        child: SizedBox(
          width: ScreenUtil().setWidth(150),
          child: Card(
            color: primary,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Center(
              child: Text(
                classroom.name,
                style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                    fontSize: ScreenUtil().setSp(fzSubTitle),
                    color: colorTextWhite),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:attendance_app/configs/values/size_widget.dart';
import 'package:attendance_app/configs/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarPrimary extends StatelessWidget {
  final Widget leading, title;

  const AppbarPrimary({this.leading, this.title})
      : assert(leading != null && title != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: bgWhite,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
      ),
      height: ScreenUtil().setHeight(heightAppbar),
      child: Stack(
        children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: leading),
          Center(
            child: title,
          ),
        ],
      ),
    );
  }
}

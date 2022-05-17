
import 'package:do_an_at140225/bloc/app_bloc/app_bloc.dart';
import 'package:do_an_at140225/bloc/app_bloc/bloc.dart';
import 'package:do_an_at140225/configs/values/colors.dart';
import 'package:do_an_at140225/views/router/route_name.dart';
import 'package:do_an_at140225/views/widgets/bg_gradient.dart';
import 'package:do_an_at140225/views/widgets/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BgGradientWidget(),
          Center(child: Text(
            'Kiểm tra đăng nhập...',
            style: Theme.of(context).primaryTextTheme.caption.copyWith(
                fontSize: ScreenUtil().setSp(20), color: colorTextWhite),
          ),),
        ],
      ),
    );
  }
}

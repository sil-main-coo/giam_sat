import 'package:do_an_at140225/configs/parse_value/parse_time.dart';
import 'package:do_an_at140225/configs/values/colors.dart';
import 'package:do_an_at140225/configs/values/string.dart';
import 'package:do_an_at140225/views/home/classrooms_bloc/bloc.dart';
import 'package:do_an_at140225/views/widgets/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'home.dart';

class LoadingHomeWidget extends StatefulWidget {
  @override
  _LoadingHomeWidgetState createState() => _LoadingHomeWidgetState();
}

class _LoadingHomeWidgetState extends State<LoadingHomeWidget> {
  final dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BgGradientWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(80),
                  ),
                  BodyLoadingHome(),
                  SizedBox(
                    height: ScreenUtil().setHeight(80),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<ClassroomsBloc>(context)
                      ..add(FetchClassrooms()),
                    child: InitHome(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyLoadingHome extends StatefulWidget {
  @override
  _AnimatedPositionState createState() => _AnimatedPositionState();
}

class _AnimatedPositionState extends State<BodyLoadingHome>
    with TickerProviderStateMixin {
  final dateTime = DateTime.now();

  AnimationController animatedFadedCtrl;
  Animation<double> animationFaded;

  AnimationController animatedPositionCtrl;
  Animation animationPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animatedPositionCtrl =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    animationPosition =
        Tween<Offset>(begin: const Offset(0, 6), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: animatedPositionCtrl, curve: Curves.fastOutSlowIn));

    animatedFadedCtrl = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    animationFaded =
        CurvedAnimation(parent: animatedFadedCtrl, curve: Curves.fastOutSlowIn);

    Future.delayed(Duration(milliseconds: 500), () {
      animatedPositionCtrl.forward();
    });

    animatedPositionCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animatedFadedCtrl.forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animatedPositionCtrl.dispose();
    animatedFadedCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: animationPosition,
          child: Text(
            AppValues.schoolName,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .primaryTextTheme
                .headline
                .copyWith(fontSize: ScreenUtil().setSp(36)),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(150),
        ),
        FadeTransition(
          opacity: animationFaded,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ParseTime.toHourMinute(dateTime),
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline
                      .copyWith(fontSize: ScreenUtil().setSp(48),  color: colorTextWhite),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                ),
                Text(
                  ParseTime.toDateDetail(dateTime),
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subhead
                      .copyWith(fontSize: ScreenUtil().setSp(20),  color: colorTextWhite),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(80),
                ),
                Text(
                  'Xin chào quý thầy cô !',
                  style: Theme.of(context).primaryTextTheme.caption.copyWith(
                      fontSize: ScreenUtil().setSp(20), color: colorTextWhite),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

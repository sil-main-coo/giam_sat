import 'package:do_an_at140225/configs/values/colors.dart';
import 'package:do_an_at140225/views/home/home_widget/drawer_bloc/bloc.dart';
import 'package:do_an_at140225/views/home/home_widget/home_widget.dart';
import 'package:do_an_at140225/views/router/route_name.dart';
import 'package:do_an_at140225/views/classroom/classroom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

RouteFactory router() {
  return (RouteSettings settings) {
    Widget screen;

    switch (settings.name) {
      case RouteName.home:
        return PageRouteBuilder(
          pageBuilder: (context, a1, a2) => BlocProvider(
            create: (context) => DrawerBloc()..add(DrawerMenuClicked(0)),
            child: HomeWidget(),
          ),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 1000),
        );
      case RouteName.classroom:
        return MaterialPageRoute(
          builder: (context) => ClassroomPage(  ),
        );
      default:
        screen = FailedRouteWidget(settings.name);
        return MaterialPageRoute(
          builder: (_) => screen,
        );
    }
  };
}

class FailedRouteWidget extends StatelessWidget {
  FailedRouteWidget(this._name);

  final String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lạc đường rồi'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.sentiment_neutral,
                size: 32,
                color: secondary,
              ),
              Text('Có vẻ bạn đã bị lạc đường $_name'),
            ],
          ),
        ),
      ),
    );
  }
}

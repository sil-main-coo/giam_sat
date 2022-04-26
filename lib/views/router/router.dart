import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/views/home/home_widget/drawer_bloc/bloc.dart';
import 'package:attendance_app/views/home/home_widget/home_widget.dart';
import 'package:attendance_app/views/login/login.dart';
import 'package:attendance_app/views/profile/profile.dart';
import 'package:attendance_app/views/router/route_name.dart';
import 'package:attendance_app/views/classroom/classroom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

RouteFactory router() {
  return (RouteSettings settings) {
    Widget screen;

    var args = settings.arguments as Map<String, dynamic>;

    switch (settings.name) {
      case RouteName.home:
        return PageRouteBuilder(
          pageBuilder: (context, a1, a2) => BlocProvider(
            create: (context) => DrawerBloc()..add(DrawerMenuClicked(0)),
            child: HomeWidget(),
          ),
          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 1000),
        );
      case RouteName.classroom:
        return MaterialPageRoute(
          builder: (context) =>  ClassroomPage(index: args['index'],),
        );
      case RouteName.profile:
        return MaterialPageRoute(builder: (_context)=> ProfilePerson(person: args['person'],));
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

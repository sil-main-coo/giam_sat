import 'package:attendance_app/bloc/app_bloc/bloc.dart';
import 'package:attendance_app/bloc/mqtt_bloc/bloc.dart';
import 'package:attendance_app/bloc/update_data_bloc/bloc.dart';
import 'package:attendance_app/provider/singletons/get_it.dart';
import 'package:attendance_app/views/home/classrooms_bloc/bloc.dart';
import 'package:attendance_app/views/home/loadings/loading_home.dart';
import 'package:attendance_app/views/login/login.dart';
import 'package:attendance_app/views/router/route_name.dart';
import 'package:attendance_app/views/router/router.dart';
import 'package:attendance_app/views/home/classrooms_bloc/classrooms_bloc.dart';
import 'package:attendance_app/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'configs/values/values.dart';
import 'views/classroom/tabs/attendance/identified/identified_bloc.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ClassroomsBloc>(
              create: (context) => locator<ClassroomsBloc>()),
          BlocProvider<UpdateDataBloc>(
              create: (context) => locator<UpdateDataBloc>()),
          BlocProvider<MQTTBloc>(create: (context) => locator<MQTTBloc>()),
        ],
        child: MaterialApp(
          title: 'Đồ án AT140225',
          initialRoute: RouteName.myApp,
          onGenerateRoute: router(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeDefault,
          home: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              ScreenUtil.init(context, width: 375, height: 812);
              if (state is AppAuthenticated) {
                return LoadingHomeWidget();
              }
              if (state is AppUnauthenticated) {
                return LoginPage();
              }
              return SplashScreen();
            },
          ),
        ));
  }
}

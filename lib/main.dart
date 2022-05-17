import 'package:do_an_at140225/app.dart';
import 'package:do_an_at140225/bloc/app_bloc/bloc.dart';
import 'package:do_an_at140225/bloc_delegate.dart';
import 'package:do_an_at140225/provider/singletons/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'configs/values/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // set color status bar and navigationbar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: secondary, // navigation bar color
      statusBarColor: primary, // status bar color
      statusBarBrightness: Brightness.light));

  setupLocator(); // setup get it : MQTT service
  BlocSupervisor.delegate = AppBlocDelegate(); // setup logging bloc

  // set only vertical screen
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(BlocProvider<AppBloc>(
        create: (context) => AppBloc(locator())
          ..add(
            AppStarted(),
          ),
        child: MyApp()));
  });
}

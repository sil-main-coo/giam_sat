import 'dart:async';
import 'package:attendance_app/bloc/app_bloc/app_event.dart';
import 'package:attendance_app/bloc/app_bloc/bloc.dart';
import 'package:attendance_app/provider/local/local_provider.dart';
import 'package:bloc/bloc.dart';


class AppBloc extends Bloc<AppEvent, AppState> {
  final LocalProvider localProvider;

  AppBloc(this.localProvider,);

  @override
  AppState get initialState => AppUninitialized();

  @override
  Stream<AppState> mapEventToState(
      AppEvent event,
      ) async* {
    if (event is AppStarted) {
      final token =
      await localProvider.getDataWithKey(LocalKeys.token) as String;

      if (token != null && token.isNotEmpty) {
        yield AppAuthenticated();
      } else {
        yield AppUnauthenticated();
      }
    }else if(event is LoggedIn){
      await localProvider.saveData(LocalKeys.token, 'token');
      yield AppAuthenticated();
    }else if(event is LogOuted){
      await localProvider.removeDataWithKey(LocalKeys.token);
      yield AppUnauthenticated();
    }
  }
}
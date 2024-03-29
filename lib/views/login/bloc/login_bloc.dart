import 'dart:async';
import 'package:do_an_at140225/bloc/app_bloc/bloc.dart';
import 'package:do_an_at140225/views/login/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppBloc appBloc;

  LoginBloc({@required this.appBloc}) : assert(appBloc!=null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        if(event.account.useName == 'admin' && event.account.password == 'admin'){
          final token ='day la token nha'; // -> lưu token
          appBloc.add(LoggedIn(token: token));
          yield HiddenLoginLoading();
          yield LoginInitial();
        }else{
          yield HiddenLoginLoading();
          yield LoginFailure(
            error: 'Sai thông tin tài khoản'
          );
        }
      } catch (error) {
        yield HiddenLoginLoading();
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
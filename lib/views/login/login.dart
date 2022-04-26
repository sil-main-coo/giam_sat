
import 'package:attendance_app/bloc/app_bloc/bloc.dart';
import 'package:attendance_app/views/login/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/bg_gradient.dart';
import 'children/input_box.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { //here
        FocusScope.of(context).unfocus();
        new TextEditingController().clear();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            BgGradientWidget(),
            BlocProvider(
              create: (context) {
                return LoginBloc(appBloc: BlocProvider.of<AppBloc>(context));
              },
              child: BoxInputLogin(),
            ),
          ],
        ),
      ),
    );
  }
}

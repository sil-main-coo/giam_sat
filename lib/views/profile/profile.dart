
import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'children/box_detail.dart';

class ProfilePerson extends StatelessWidget {
  const ProfilePerson({this.person});

  final Person person;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            _coverImage(context,),
            _buttonBack(context),
            InformationBox(person: person,),
          ],
        ),
      ),
    );

  }

  _buttonBack(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: Icon(Icons.arrow_back, color: colorIconWhite,),
          onPressed: ()=> Navigator.pop(context)),
        )
    );
  }

  _coverImage(BuildContext context) {
    final String assetName = 'assets/images/cover.png';
    final Widget cover = Image.asset(assetName, fit: BoxFit.cover,);

    return Container(
      height: ScreenUtil().setHeight(325),
      width: double.infinity,
      child: cover,
    );
  }
}
class InformationBox extends StatelessWidget {
  const InformationBox({this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SafeArea(child: SizedBox(height: ScreenUtil().setHeight(20),)),
        Container(
         // height: ScreenUtil().setHeight(250),
          child: Column(
            children: <Widget>[
              _avatar(),
              SizedBox(height: ScreenUtil().setHeight(10)),
              _name(context, 0),
              SizedBox(height: ScreenUtil().setHeight(10)),
              _code(context),
              SizedBox(height: 10,),
              BoxDetailProfile(person: person,)
            ],
          ),
        ),
      ],
    );
  }

  _avatar() {
    return CircleAvatar(
      radius: ScreenUtil().setWidth(60),
      backgroundImage: AssetImage(person.avatar),
    );
  }

  _name(BuildContext context, int status) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(person.fullName, style: Theme.of(context).primaryTextTheme.title.copyWith(color: colorTextWhite),),
//        Padding(
//          padding: const EdgeInsets.only(left: 8.0),
//          child: Container(
//            width: 10,
//            height: 10,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(90.0),
//              color: status == 1 ? colorAttended : colorNoAttend,
//            ),
//          ),
//        ),
      ],
    );
  }

  _code(BuildContext context) {
    return Text(person.id, style: Theme.of(context).primaryTextTheme.subtitle.copyWith(color: colorTextWhite),);
  }
}

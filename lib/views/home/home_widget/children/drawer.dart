import 'package:attendance_app/bloc/app_bloc/app_event.dart';
import 'package:attendance_app/bloc/app_bloc/bloc.dart';
import 'package:attendance_app/bloc/mqtt_bloc/bloc.dart';
import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/configs/values/string.dart';
import 'package:attendance_app/configs/values/values.dart';
import 'package:attendance_app/views/home/home_widget/drawer_bloc/bloc.dart';
import 'package:attendance_app/views/router/route_name.dart';
import 'package:attendance_app/views/widgets/dialogs/dialogs.dart';
import 'package:attendance_app/views/widgets/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeHeader = ScreenUtil().setHeight(250);

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
        child: Drawer(
          child: Container(
            color: bgWhite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _header(context, sizeHeader),
                _menus(context),
                _logOut(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(BuildContext context, double sizeHeader) {
    return Container(
      decoration: const BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
      ),
      height: sizeHeader,
      width: double.infinity,
      child: HeaderDrawer(),
    );
  }

  _menus(BuildContext context) {
    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        if (state is IndexDrawerClicked) {
          return Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                MenuItem(0, 'Quản lý phòng học', Icons.home,
                    state.index == 0 ? secondary : colorTextBlack),
//                MenuItem(1, 'Thông tin ứng dụng', Icons.info,
//                    state.index == 1 ? secondary : colorTextBlack),
              ],
            ),
          );
        }
        return AppLoadingWidget();
      },
    );
  }

  _logOut(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        onTap: () => AppDialog.showActionsDialog(
            context: context,
            mess: 'Bạn muốn đăng xuất?',
            textBtnR: 'Đồng ý',
            textBtnL: 'Hủy',
            colorR: primary,
            colorL: secondary,
            functionR: () {
              BlocProvider.of<MQTTBloc>(context).add(DisconnectMQTTT());
              BlocProvider.of<AppBloc>(context)..add(LogOuted());
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.myApp, (route) => false);
            },
            functionL: () => Navigator.pop(context)),
        leading: Icon(FontAwesomeIcons.signOutAlt),
        title: Text(
          'Đăng xuất',
          style: Theme.of(context).primaryTextTheme.body2.copyWith(
              fontSize: ScreenUtil().setSp(
                fzBody2,
              ),
              color: colorTextBlack),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color color;

  MenuItem(this._index, this.title, this.iconData, this.color);

  final int _index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _clickedMenu(context, _index),
      leading: Icon(
        iconData,
        color: color,
      ),
      title: Text(
        title,
        style: Theme.of(context).primaryTextTheme.body2.copyWith(
            fontSize: ScreenUtil().setSp(
              fzBody2,
            ),
            color: color),
      ),
    );
  }

  _clickedMenu(BuildContext context, int index) {
    BlocProvider.of<DrawerBloc>(context)..add(DrawerMenuClicked(index));
    Navigator.pop(context); // pop drawer
  }
}

class HeaderDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/images/avatar.png';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            radius: ScreenUtil().setWidth(40),
            backgroundImage: AssetImage(assetName),
          ),
          Text(
            AppValues.schoolName,
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.title.copyWith(
                color: colorTextWhite, fontSize: ScreenUtil().setSp(fzTitle)),
          ),
          Text(
            'thcsbinhkhe@dongtrieu.edu.vn',
            style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: transparentWhite56,
                fontSize: ScreenUtil().setSp(fzCaption)),
          )
        ],
      ),
    );
  }
}

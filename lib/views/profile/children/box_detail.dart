
import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/model/user.dart';
import 'package:attendance_app/views/widgets/circle_tap_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'history_tab.dart';
import 'information_tab.dart';

class BoxDetailProfile extends StatelessWidget {
  const BoxDetailProfile({this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {

    return _buildContent();
  }

  _buildContent(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: ScreenUtil().setHeight(500),
        width: double.infinity,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
          child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TabBar(
                  labelColor: secondary,
                    indicator: CircleTabIndicator(color: secondary, radius: 3),
                    tabs: [
                      Tab(text: 'Thông tin',),
                      Tab(text: 'Lịch sử',),
                    ]
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      InformationTab(person: person,),
                      HistoryAttendanceTab(attendance: person.attendances,),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

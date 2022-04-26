import 'dart:async';

import 'package:attendance_app/bloc/update_data_bloc/bloc.dart';
import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/configs/values/size_widget.dart';
import 'package:attendance_app/model/api/persons.dart';
import 'package:attendance_app/views/classroom/tabs/attendance/children/dialog_info.dart';
import 'package:attendance_app/views/classroom/tabs/attendance/identified/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'children/floatting_btn.dart';
import 'children/item_person_status.dart';

class AttendanceTab extends StatefulWidget {
  const AttendanceTab({this.persons, this.nameRoom});

  final List<Person> persons;
  final String nameRoom;

  @override
  _ClassroomPageState createState() => _ClassroomPageState();
}

class _ClassroomPageState extends State<AttendanceTab>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _hideFabAnimController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IdentifiedBloc, IdentifiedState>(
      bloc: BlocProvider.of<UpdateDataBloc>(context).identifiedBloc,
      listener: (context, state) {
        if (state is IdentifiedSuccess) {
          DialogIdentifiedInfo.show(context, state.person);
          if (DialogIdentifiedInfo.isDialogShowing) {
            Timer(Duration(seconds: 5), () {
              if (DialogIdentifiedInfo.isDialogShowing) {
                DialogIdentifiedInfo.hide(context);
              }
            });
          }
        }
      },
      builder: (context, state) => _buildBody(),
    );
  }

  _buildBody() {
    final listPerson = widget.persons;
    final countItem = listPerson.length;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FadeTransition(
          opacity: _hideFabAnimController,
          child: ScaleTransition(
              scale: _hideFabAnimController,
              child: FloatingExportButton(
                persons: listPerson,
                nameRoom: widget.nameRoom,
              ))),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) => Container(
            color: borderBlack,
            height: 1,
          ),
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: countItem,
          itemBuilder: (context, index) {
            return PersonStatusItem(
              index: index,
              person: listPerson[index],
            );
          },
        ),
      ),
    );
  }

  _buildBgHeader(bool checkFirstItem) {
    return Container(
      color: checkFirstItem ? secondary : primary,
      height: ScreenUtil().setHeight(heightAppbar + 10),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

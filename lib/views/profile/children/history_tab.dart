import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/model/api/api.dart';
import 'package:attendance_app/views/widgets/animations/delay_animation.dart';
import 'package:flutter/material.dart';

class HistoryAttendanceTab extends StatefulWidget {
  HistoryAttendanceTab({this.attendance});

  final List<Attendance> attendance;

  @override
  _HistoryAttendanceTabState createState() => _HistoryAttendanceTabState();
}

class _HistoryAttendanceTabState extends State<HistoryAttendanceTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return widget.attendance.isEmpty
        ? Center(
      child: Text('Chưa có dữ liệu'),
    )
        : ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.attendance.length,
        itemBuilder: (context, index) {
          final attendance = widget.attendance[index];

          return DelayedAnimation(
            delay: 100 * index,
            offset: Offset(0, 0.36),
            child: ListTile(
              title: Text(
                  '${attendance.hourMinuteString} - ${attendance.dMyString}'),
              trailing: Text(
                'Đã điểm danh',
                style: Theme.of(context)
                    .primaryTextTheme
                    .caption
                    .copyWith(color: colorAttended),
              ),
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

import 'package:attendance_app/configs/values/colors.dart';
import 'package:attendance_app/model/models.dart';
import 'package:attendance_app/views/widgets/animations/delay_animation.dart';
import 'package:flutter/material.dart';


class InformationTab extends StatefulWidget {
  InformationTab({this.person});

  final Person person;


  @override
  _InformationTabState createState() => _InformationTabState();
}


class _InformationTabState extends State<InformationTab> with AutomaticKeepAliveClientMixin{
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DelayedAnimation(
            delay: 300,
            offset: Offset(0, 0.36),
            child: ListTile(
              leading: Icon(Icons.sd_card, color: secondary,),
              title: Text(widget.person.id),
            ),
          ),
          DelayedAnimation(
            delay: 100,
            offset: Offset(0,0.36),
            child: ListTile(
              leading: Icon(Icons.person, color: secondary,),
              title: Text(widget.person.fullName),
            ),
          ),
          DelayedAnimation(
            delay: 100,
            offset: Offset(0,0.36),
            child: ListTile(
              leading: Icon(Icons.date_range, color: secondary,),
              title: Text(widget.person.birthday),
            ),
          ),
          DelayedAnimation(
            delay: 500,
            offset: Offset(0,0.36),
            child: ListTile(
              leading: Icon(Icons.group, color: secondary,),
              title: Text(widget.person.classroom??'Chưa cập nhật'),
            ),
          ),
          DelayedAnimation(
            delay: 500,
            offset: Offset(0,0.36),
            child: ListTile(
              leading: Icon(Icons.phone, color: secondary,),
              title: Text(widget.person.phone??'Chưa cập nhật'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

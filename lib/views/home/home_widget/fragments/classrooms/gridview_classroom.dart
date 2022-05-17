import 'package:do_an_at140225/bloc/update_data_bloc/bloc.dart';
import 'package:do_an_at140225/configs/values/colors.dart';
import 'package:do_an_at140225/configs/values/font_size.dart';
import 'package:do_an_at140225/views/widgets/animations/delay_animation.dart';
import 'package:do_an_at140225/views/widgets/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_classroom.dart';

class Classrooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'DANH SÁCH PHÒNG HỌC',
            style: Theme.of(context).primaryTextTheme.title.copyWith(
                fontSize: ScreenUtil().setSp(fzSubTitle), color: primaryDark),
          ),
        ),
        DelayedAnimation(
            offset: const Offset(0, 0.35),
            delay: 150,
            child: BlocBuilder<UpdateDataBloc, UpdateDataState>(
              builder: (context, state) {
                if (state is LoadedData) {
                  return SizedBox(
                    height: ScreenUtil().setHeight(150),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ItemClassroom(
                          index: index, classroom: state.classrooms[index]),
                      itemCount: state.classrooms.length,
                    ),
                  );
                }
                return AppLoadingWidget(
                  mess: 'Xin chờ...',
                );
              },
            )),
      ],
    );
  }
}

import 'dart:io';
import 'package:attendance_app/configs/values/values.dart';
import 'package:attendance_app/model/api/api.dart';
import 'package:attendance_app/views/widgets/dialogs/dialogs.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class FloatingExportButton extends StatelessWidget {
  final List<Person> persons;
  final String nameRoom;

  FloatingExportButton({this.persons, this.nameRoom});

  final date = DateTime.now();

  _createExcel(BuildContext context, String fileName) async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      var pathFile = "/$fileName.xlsx";
      var excel = Excel.createExcel();

      // if sheet with name = Trang1 does not exist then it will be automatically created.
      var sheet = 'Trang1';

      excel.updateCell(
          sheet, CellIndex.indexByString("A1"), 'Điểm danh phòng $nameRoom');
      excel.updateCell(sheet, CellIndex.indexByString("A2"),
          '${date.day}/${date.month}/${date.year}');

      excel.updateCell(
        sheet,
        CellIndex.indexByString("A5"),
        'STT',
      );
      excel.updateCell(
        sheet,
        CellIndex.indexByString("B5"),
        'Mã nhận diện',
      );
      excel.updateCell(
        sheet,
        CellIndex.indexByString("C5"),
        'Họ và tên',
      );
      excel.updateCell(
        sheet,
        CellIndex.indexByString("D5"),
        'Trạng thái',
      );
      excel.updateCell(
        sheet,
        CellIndex.indexByString("E5"),
        'Ghi chú',
      );

      for (int i = 6; i < persons.length + 6; i++) {
        final p = persons[i - 6];

        excel.updateCell(
          sheet,
          CellIndex.indexByString("A$i"),
          '${i - 5}',
        );
        excel.updateCell(
          sheet,
          CellIndex.indexByString("B$i"),
          p.id,
        );
        excel.updateCell(
          sheet,
          CellIndex.indexByString("C$i"),
          p.fullName,
        );
        excel.updateCell(
          sheet,
          CellIndex.indexByString("D$i"),
          p.isAttendance ? 'Đã điểm danh' : 'Chưa điểm danh',
        );
        excel.updateCell(
          sheet,
          CellIndex.indexByString("E$i"),
          p.isAttendance ? p.lastAttendance.hourMinuteString : '',
        );
      }

      // set default sheet
      excel.setDefaultSheet(sheet).then((isSet) {
        // isSet is bool which tells that whether the setting of default sheet is successful or not.
        if (isSet) {
          debugPrint("$sheet is set to default sheet.");
        } else {
          debugPrint("Unable to set $sheet to default sheet.");
        }
      });

      for (var table in excel.tables.keys) {
        print(table);
        print(excel.tables[table].maxCols);
        print(excel.tables[table].maxRows);
        for (var row in excel.tables[table].rows) {
          print("$row");
        }
      }

      // Saving the file
      String outputFile;

      if (Platform.isAndroid) {
        outputFile = "/sdcard$pathFile";
      } else {
        outputFile = (await getApplicationDocumentsDirectory()).path + pathFile;
      }

      excel.encode().then((onValue) async {
        File(outputFile)
          ..createSync(recursive: true)
          ..writeAsBytesSync(onValue);
//        print('>>>path file: $outputFile');
        AppDialog.showActionsDialog(
            context: context,
            mess: 'Bạn có muốn mở file $fileName?',
            textBtnR: 'Mở',
            textBtnL: 'Đóng',
            colorR: primary,
            colorL: secondary,
            functionR: () async {
              final result = await OpenFile.open(outputFile);
              print("type=${result.type}  message=${result.message}");
            },
            functionL: () => Navigator.pop(context));
      });
    } else {
      Toast.show('Bạn cần cấp quyền truy cập bộ nhớ', context,
          duration: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _createExcel(context, 'Diemdanh_$nameRoom'),
      heroTag: 'file',
      tooltip: 'file',
      backgroundColor: Colors.orange,
      child: Icon(
        FontAwesomeIcons.fileExport,
        color: colorIconWhite,
      ),
    );
  }
}

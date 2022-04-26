//
//import 'package:attendance_app/configs/connection/enum_error.dart';
//import 'package:attendance_app/configs/connection/key_firebase.dart';
//import 'package:attendance_app/model/result_request.dart';
//import 'package:flutter/cupertino.dart';
//
//abstract class RepoProfile{
//  Future<ResultRequest> updateHistoryAttendance(String code, int time);
//}
//
//class ProfileApi extends RepoProfile{
//  final _databaseReference = Firestore.instance;
//
//  @override
//  Future<ResultRequest> updateHistoryAttendance(String code, int time) async {
//    return _databaseReference.collection(KeyFirebase.userCollection)
//        .document(code)
//        .updateData({
//      KeyFirebase.timeField: FieldValue.arrayUnion([time])
//    }).then((data) {
//      return ResultRequest.fromJson(true);
//    }).catchError((err) {
//      debugPrint('>>> FAILED: $err}');
//      return ResultRequest.err(STATUS_ERROR.HAS_ERR);
//    });
//  }
//
//}
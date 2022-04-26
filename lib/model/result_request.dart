import 'package:attendance_app/configs/connection/enum_error.dart';

class ResultRequest{
  bool _success;
  STATUS_ERROR _stt;

  ResultRequest.fromJson(this._success);

  ResultRequest.err(this._stt){
    _success = false;
  }

  STATUS_ERROR get err => _stt;

  bool get success => _success;


}
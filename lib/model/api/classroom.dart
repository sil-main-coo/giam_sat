import 'package:equatable/equatable.dart';
import 'api.dart';

final jsonSensors = {
  'topic_string': 'node_AT140225_data',
  'qos': 1,
  'params': [
    {'temp': '30.00', 'qos': 1, 'hum': '44.4', 'gas': '12.2', 'lux': '469'}
  ],
};

final jsonOffline = {
  'topic_string': 'node_AT140225_offline',
  'qos': 1,
  'params': [
    {'qos': 1, 'temp': 30.2, 'hum': 44.4, 'smoke': 12.2}
  ],
};

final jsonDevices = {
  'topic_string': 'node_dt010133_stt',
  'qos': 1,
  'devices': [
    {'label': 'Đèn', 'name': 'tb1', 'status': 0},
    {'label': 'Quạt', 'name': 'tb2', 'status': 0}
  ],
};

final jsonRemote = {
  'topic_string': 'node_AT140225_remote',
  'qos': 1,
};

final jsonPersons = {
  'topic_string': 'node_dt010133_id',
  'qos': 1,
  'persons': [
    {
      'id': 'TA_MINH_SON',
      'full_name': 'Tạ Minh Sơn',
      'avatar': 'assets/images/profile/ta_minh_son.jpg',
      'birthday': '07/11/1990',
      'sex': 1,
      'classroom': 'Giáo viên toán',
      'attendances': []
    },
    {
      'id': 'VU_HOANG_SON',
      'full_name': 'Vũ Hoàng Sơn',
      'avatar': 'assets/images/profile/vu_hoang_son.JPG',
      'birthday': '14/01/2006',
      'sex': 1,
      'classroom': '9D1',
      'attendances': []
    },
    {
      'id': 'NGUYEN_MINH_QUANG',
      'full_name': 'Nguyễn Minh Quang',
      'avatar': 'assets/images/profile/nguyen_minh_quang.JPG',
      'birthday': '27/09/2006',
      'sex': 1,
      'classroom': '9D1',
      'attendances': []
    },
    {
      'id': 'NGO_QUANG_HUY',
      'full_name': 'Ngô Quang Huy',
      'avatar': 'assets/images/profile/ngo_quang_huy.JPG',
      'birthday': '08/08/2006',
      'sex': 1,
      'classroom': '9D1',
      'attendances': []
    },
    {
      'id': 'DAO_CAM_ANH',
      'full_name': 'Đào Cẩm Anh',
      'avatar': 'assets/images/profile/dao_cam_anh.JPG',
      'birthday': '21/12/2007',
      'sex': 0,
      'classroom': '8C1',
      'attendances': []
    }
  ],
};

class Classroom extends Equatable {
  final String id, name, address;
  final AppSensors appSensors;
  final Remote remote;
  final Devices devices;
  final Persons persons;
  bool haveSleep;

  Classroom(
      {this.id,
      this.name,
      this.address,
      this.appSensors,
      this.persons,
      this.devices,
      this.haveSleep = false,
      this.remote});

  @override
  // TODO: implement props
  List<Object> get props =>
      [id, name, address, appSensors, remote, devices, persons, haveSleep];

  @override
  // TODO: implement stringify
  bool get stringify => true;
}

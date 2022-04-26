import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../models.dart';

class Persons extends AppTopic with EquatableMixin {
  List<Person> _persons;

  Persons(String topicString, MqttQos qos, this._persons)
      : super(topicString: topicString, qos: qos);

  Persons.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
//    print(json.toString());
    final data = json['persons'];
    _persons = List();
    if (data != null)
      data.forEach((f) {
        _persons.add(Person.fromJson(f));
      });
    if (_persons.isNotEmpty) {
      sortPerson();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic_string'] = this.topicString;
    data['qos'] = this.qos.index;
    if (this.persons != null) {
      data['persons'] = this.persons.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void sortPerson() {
    _persons.sort((a, b) {
      {
        if (a.isAttendance == null && b.isAttendance == null ||
            !a.isAttendance && !b.isAttendance) {
          return a.fullName.compareTo(b.fullName);
        } else if (a.isAttendance && b.isAttendance) {
          return a.lastAttendance.time.compareTo(b.lastAttendance.time);
        } else {
          return a.isAttendance ? 1 : -1;
        }
      }
    });
  }

  List<Person> get persons => _persons.reversed.toList();

  @override
  // TODO: implement props
  List<Object> get props => [_persons];
}

class Person extends Equatable {
  String _id;
  String _fullName;
  String _email;
  String _sex;
  String _birthday;
  String _classroom;
  String _phone;
  String _avatar;
  Attendance _lastAttendance;
  bool _isAttendance;
  List<Attendance> _attendances;

  Person(this._id, this._fullName, this._email, this._phone, this._avatar,
      this._attendances);

  Person.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _email = json['email'];
    _sex = json['sex'] == 0 ? 'Nữ' : 'Nam';
    _birthday = json['birthday'];
    _classroom = json['classroom'];
    _phone = json['phone'];
    _avatar = json['avatar'];

    final attendData = json['attendances'];
    _attendances = List();
    attendData.forEach((f) {
      _attendances.add(Attendance.fromJson(f));
    });

    if (_attendances.isNotEmpty) {
      final now = DateTime.now();

      _lastAttendance = _attendances[_attendances.length - 1];
      _isAttendance = _lastAttendance.time.day == now.day &&
          _lastAttendance.time.month == now.month &&
          _lastAttendance.time.year == now.year;
    } else {
      _isAttendance = false;
    }
  }

  void attended(Attendance attendance) {
    _isAttendance = true;
    _attendances.add(attendance); // add vào đầu danh sách
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['classroom'] = this.classroom;
    data['avatar'] = this.avatar;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    if (this.attendances != null) {
      data['attendances'] = this.attendances.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get isAttendance => _isAttendance;

  String get avatar => _avatar;

  String get phone => _phone;

  String get email => _email;

  String get fullName => _fullName;

  String get id => _id;

  Attendance get lastAttendance =>
      _attendances.isNotEmpty ? _attendances[_attendances.length - 1] : null;

  List<Attendance> get attendances => _attendances;

  String get sex => _sex;

  @override
  // TODO: implement props
  List<Object> get props => [id, fullName, email, phone, avatar, isAttendance];

  @override
  // TODO: implement stringify
  bool get stringify => true;

  String get birthday => _birthday;

  String get classroom => _classroom;
}

class Attendance extends Equatable {
  DateTime _time;
  String _timeFromData;
  int _status;
  final _fmString = DateFormat("hh/mm/ss/dd/MM/yyyy");
  final _fmDay = new DateFormat('dd/MM/yyyy');
  final _fmHour = new DateFormat('hh:mm a');

  Attendance(String time, this._status) {
    _timeFromData = time;
    _time = _fmString.parse(time);
  }

  Attendance.fromJson(Map<String, dynamic> json) {
    if (json['time'] != null) _time = _fmString.parse(json['time'].toString());
    _status = json['status'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this._timeFromData;
    return data;
  }

  DateTime get time => _time;

  String get dMyString => _fmDay.format(_time);

  String get hourMinuteString => _fmHour.format(_time);

  @override
  // TODO: implement props
  List<Object> get props => [time, status, _timeFromData];

  int get status => _status;
}

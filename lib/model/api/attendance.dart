class Attendance{
  var _id;
  var _time;
  var _idClassroom;
  var _idPerson;

  Attendance(this._id, this._time, this._idClassroom, this._idPerson);

  Attendance.fromJson(Map<String, dynamic> json){
    _id= json['id'];
    _time= json['time'];
    _idClassroom= json['id_classroom'];
    _idPerson= json['id_person'];
  }

  get idPerson => _idPerson;

  get idClassroom => _idClassroom;

  get time => _time;

  get id => _id;

  set idPerson(value) {
    _idPerson = value;
  }

  set idClassroom(value) {
    _idClassroom = value;
  }

  set time(value) {
    _time = value;
  }

  set id(value) {
    _id = value;
  }


}
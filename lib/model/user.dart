
import 'dart:math';

class User{
  String _name, _code, _email, _phone, _avatar, _cover;

  User.fromJson(){
//    name = json['name'];
//    code = json['code'];
//    email = json['email'];
//    phone = json['phone'];
//    avatar = json['avatar'];
//    cover = json['cover'];

  }

  String get name => _name;

  get code => _code;

  get cover => _cover;

  get avatar => _avatar;

  get phone => _phone;

  get email => _email;
}
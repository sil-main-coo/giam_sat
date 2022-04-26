import 'package:attendance_app/model/models.dart';
import 'package:equatable/equatable.dart';

class IdentifiedState extends Equatable {
  const IdentifiedState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitIdentified extends IdentifiedState {}

class IdentifiedSuccess extends IdentifiedState {
  final Person person;
  final bool isChange;

  IdentifiedSuccess({this.person, this.isChange = true})
      : assert(person != null);

  IdentifiedSuccess copyWith({
    Person person,
  }) {
    return IdentifiedSuccess(
        person: person ?? this.person, isChange: !this.isChange);
  }

  @override
  // TODO: implement props
  List<Object> get props => [person, isChange];
}

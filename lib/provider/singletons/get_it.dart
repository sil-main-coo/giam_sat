import 'package:attendance_app/bloc/mqtt_bloc/mqtt_bloc.dart';
import 'package:attendance_app/bloc/update_data_bloc/update_data_bloc.dart';
import 'package:attendance_app/provider/local/local_provider.dart';
import 'package:attendance_app/provider/local/persons_local_provider.dart';
import 'package:attendance_app/provider/mqtt/mqtt_service.dart';
import 'package:attendance_app/views/classroom/tabs/attendance/identified/identified_bloc.dart';
import 'package:attendance_app/views/home/classrooms_bloc/classrooms_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<MQTTService>(() => MQTTService());

  locator.registerLazySingleton(() => ClassroomsBloc(locator()));
  locator
      .registerLazySingleton(() => UpdateDataBloc(IdentifiedBloc(), locator()));
  locator.registerLazySingleton(() => MQTTBloc(locator()));

  locator.registerLazySingleton<LocalProvider>(() => LocalProviderImpl());
  locator.registerFactory<PersonLocalProvider>(() => PersonLocalProvider());
}

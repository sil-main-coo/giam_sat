import 'package:do_an_at140225/bloc/mqtt_bloc/mqtt_bloc.dart';
import 'package:do_an_at140225/bloc/update_data_bloc/update_data_bloc.dart';
import 'package:do_an_at140225/provider/local/local_provider.dart';
import 'package:do_an_at140225/provider/mqtt/mqtt_service.dart';
import 'package:do_an_at140225/views/home/classrooms_bloc/classrooms_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<MQTTService>(() => MQTTService());

  locator.registerLazySingleton(() => ClassroomsBloc());
  locator
      .registerLazySingleton(() => UpdateDataBloc());
  locator.registerLazySingleton(() => MQTTBloc(locator()));

  locator.registerLazySingleton<LocalProvider>(() => LocalProviderImpl());
}

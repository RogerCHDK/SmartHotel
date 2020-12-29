import 'package:get_it/get_it.dart';
import 'package:hoteles/core/services/Api.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('hoteles'));
  locator.registerLazySingleton(() => CRUDHotel());
}

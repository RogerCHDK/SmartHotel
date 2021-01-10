import 'package:get_it/get_it.dart';
import 'package:hoteles/core/services/Api.dart';
import 'package:hoteles/core/services/ApiHabitacion.dart';
import 'package:hoteles/core/services/ApiReservacion.dart';
import 'package:hoteles/core/services/ApiUser.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/core/viewmodels/CRUDReservacion.dart';
import 'package:hoteles/core/viewmodels/CRUDUser.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('hoteles'));
  locator.registerLazySingleton(() => CRUDHotel());
  locator.registerLazySingleton(() => ApiHabitacion('habitaciones'));
  locator.registerLazySingleton(() => CRUDHabitacion());
  locator.registerLazySingleton(() => ApiReservacion('reservaciones'));
  locator.registerLazySingleton(() => CRUDReservacion());
  locator.registerLazySingleton(() => ApiUser('usuarios'));
  locator.registerLazySingleton(() => CRUDUser());
}

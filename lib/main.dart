import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/core/viewmodels/CRUDReservacion.dart';
import 'package:hoteles/locator.dart';
import 'package:hoteles/router.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<CRUDHotel>()),
        ChangeNotifierProvider(create: (_) => locator<CRUDHabitacion>()),
        ChangeNotifierProvider(create: (_) => locator<CRUDReservacion>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Hotel App',
        theme: ThemeData(),
        onGenerateRoute: Ruta.generateRoute,
      ),
    );
  }
}

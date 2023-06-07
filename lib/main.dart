import 'package:flutter/material.dart';
import 'package:simple_notes/models/note.dart';
import 'package:simple_notes/utils/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/database_service.dart';
void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(DatabaseService.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Simple Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
    routeInformationParser: AppRoutes.goRouter.routeInformationParser,
    routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
    routerDelegate: AppRoutes.goRouter.routerDelegate,
    );
  }
}
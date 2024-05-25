import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi/controllers/favorite.dart';
import 'package:responsi/models/boxes.dart';
import 'package:responsi/controllers/navigation.dart';
import 'package:responsi/models/kopi.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteAdapter());
  // Hive.registerAdapter(JenisKopiAdapter());
  await Hive.openBox<Favorite>(HiveBoxex.favorite);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Responsiii',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}

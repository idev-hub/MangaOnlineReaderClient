import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangaonline/screens/ExploreScreen.dart';
import 'package:mangaonline/utils/themes.dart';

final storage = FlutterSecureStorage();

void main() => runApp(MangaOnlineApp());

class MangaOnlineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Манга Онлайн',
      themeMode: ThemeMode.dark,
      darkTheme: themeDataDark,
      theme: themeDataLight,
      home: ExploreScreen(),
    );
  }
}

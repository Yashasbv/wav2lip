import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wav2lip/constants/theme.dart';
import 'package:wav2lip/screen/main_screen.dart';
import 'package:wav2lip/screen/splash_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Where is my bus',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: {
        '/': (ctx) => const SplashScreen(),
        MainScreen.routeName: (ctx) => const MainScreen(),
      },
    );
  }
}

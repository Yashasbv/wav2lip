import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lottie/lottie.dart';
import 'package:wav2lip/screen/main_screen.dart';

import 'package:wav2lip/size_config.dart';
import 'package:wav2lip/widgets/background_container.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: BackgroundContainer(
          child: Center(
            child: Lottie.asset(
              'assets/animation/1732539536007.json',
              onLoaded: (p0) => {
                Future.delayed(const Duration(seconds: 5), () {
                  Navigator.of(context)
                      .pushReplacementNamed(MainScreen.routeName);
                })
              },
            ),
          ),
        ),
      ),
    );
  }
}

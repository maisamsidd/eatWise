import 'package:eat_wise/Controllers/splash_services.dart';
import 'package:eat_wise/Utils/app_colors.dart';
import 'package:eat_wise/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splash = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash.SplashFunction();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Eat Wise",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            const Text(
              "Your personal nutrition guide",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: mq.height * 0.03,
            ),
            const CircularProgressIndicator(),
            SizedBox(
              height: mq.height * 0.03,
            ),
            const Text(
              "@2025 Eat Wise, All rights reserved",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

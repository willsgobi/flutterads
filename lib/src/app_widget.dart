import 'package:flutter/material.dart';
import 'package:flutter_ads/src/features/ads/ui/add_interest.dart';
import 'package:flutter_ads/src/features/ads/ui/ads_page.dart';
import 'package:flutter_ads/src/features/app_start/ui/app_start.dart';
import 'package:flutter_ads/src/features/auth/login/ui/login_page.dart';
import 'package:flutter_ads/src/features/auth/register/ui/register_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterPage());
          case '/ads':
            return MaterialPageRoute(builder: (context) => const AdsPage());
          case '/addInterest':
            return MaterialPageRoute(
                builder: (context) => const AddInterestPage());
          case '/':
          default:
            return MaterialPageRoute(builder: (context) => const AppStart());
        }
      },
    );
  }
}

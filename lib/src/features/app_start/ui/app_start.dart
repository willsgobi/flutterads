import 'package:flutter/material.dart';
import 'package:flutter_ads/src/features/app_start/usecases/check_user_logged.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final navigator = Navigator.of(context);
      if (await context.read<CheckUserLogged>().userIsLogged()) {
        navigator.pushReplacementNamed('/ads');
      } else {
        navigator.pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

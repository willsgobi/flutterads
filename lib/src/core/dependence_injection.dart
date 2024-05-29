import 'package:flutter/material.dart';
import 'package:flutter_ads/src/features/ads/cubit/ads_cubit.dart';
import 'package:flutter_ads/src/features/ads/usecases/add_interest.dart';
import 'package:flutter_ads/src/features/ads/usecases/delete_interest.dart';
import 'package:flutter_ads/src/features/ads/usecases/do_signout.dart';
import 'package:flutter_ads/src/features/ads/usecases/get_user_data.dart';
import 'package:flutter_ads/src/features/app_start/usecases/check_user_logged.dart';
import 'package:flutter_ads/src/features/auth/login/cubit/login_cubit.dart';
import 'package:flutter_ads/src/features/auth/login/usecases/user_login.dart';
import 'package:flutter_ads/src/features/auth/register/cubit/register_cubit.dart';
import 'package:flutter_ads/src/features/auth/register/usecases/user_register.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DependencyInjection extends StatelessWidget {
  final Widget child;
  const DependencyInjection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // useCases providers
        Provider(
          create: (context) => UserRegister(),
        ),
        Provider(
          create: (context) => CheckUserLogged(),
        ),
        Provider(
          create: (context) => UserLogin(),
        ),
        Provider(
          create: (context) => DoSignOut(),
        ),
        Provider(
          create: (context) => GetUserData(),
        ),
        Provider(
          create: (context) => AddInterest(),
        ),
        Provider(
          create: (context) => DeleteInterest(),
        ),

        // cubit providers
        BlocProvider(
          create: (context) => RegisterCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => AdsCubit(context.read()),
        )
      ],
      child: child,
    );
  }
}

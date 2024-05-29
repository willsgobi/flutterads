import 'package:flutter/material.dart';
import 'package:flutter_ads/firebase_options.dart';
import 'package:flutter_ads/src/app_widget.dart';
import 'package:flutter_ads/src/core/dependence_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

void main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ui.platformViewRegistry.registerViewFactory(
    'ad-container',
    (int viewId) => html.DivElement()..id = 'ad-host',
  );

  runApp(const FlutterAdsApp());
}

class FlutterAdsApp extends StatelessWidget {
  const FlutterAdsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DependencyInjection(child: AppWidget());
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:html';

class AdSenseWidget extends StatefulWidget {
  final String adSlot;
  final String adFormat;
  final String adClient;
  final Map<String, String>? targetingOptions;

  const AdSenseWidget({
    super.key,
    required this.adSlot,
    required this.adFormat,
    required this.adClient,
    this.targetingOptions,
  });

  @override
  _AdSenseWidgetState createState() => _AdSenseWidgetState();
}

class _AdSenseWidgetState extends State<AdSenseWidget> {
  @override
  void initState() {
    super.initState();
    _createAdSenseElement();
  }

  void _createAdSenseElement() {
    final adElement = DivElement()
      ..id = 'ad-container'
      ..style.width = '100%'
      ..style.height = 'auto'
      ..innerHtml = '''
      <ins class="adsbygoogle"
           style="display:block"
           data-ad-client="${widget.adClient}"
           data-ad-slot="${widget.adSlot}"
           data-ad-format="${widget.adFormat}"></ins>
      ''';

    if (widget.targetingOptions != null) {
      for (var entry in widget.targetingOptions!.entries) {
        adElement.setAttribute('data-${entry.key}', entry.value);
      }
    }

    if (document.getElementById('adsense-script') == null) {
      final scriptElement = ScriptElement()
        ..id = 'adsense-script'
        ..type = 'text/javascript'
        ..async = true
        ..src =
            'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js';
      document.head!.append(scriptElement);

      scriptElement.onLoad.listen((event) {
        _initializeAds();
      });
    } else {
      _initializeAds();
    }

    document.getElementById('ad-host')?.append(adElement);
  }

  void _initializeAds() {
    final script = ScriptElement()
      ..innerHtml = '(adsbygoogle = window.adsbygoogle || []).push({});';
    document.getElementById('ad-container')?.append(script);
  }

  @override
  Widget build(BuildContext context) {
    return const HtmlElementView(viewType: 'ad-container');
  }
}

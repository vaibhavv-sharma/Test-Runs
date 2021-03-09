import 'dart:developer';
import 'package:flutter/services.dart';

typedef MethodResponse<T> = void Function(T value);

enum Environment { develop, production }

class AppConfig {
  static final String kChannelName = 'flavor';
  static final String kMethodName = 'getFlavor';

  Environment flavor;
  final String apiBaseUrl;

  AppConfig({this.flavor, this.apiBaseUrl});

  static AppConfig _instance;

  static AppConfig getInstance() => _instance;

  static configure(MethodResponse fn) async {
    try {
      final flavor =
          await MethodChannel(kMethodName).invokeMethod<String>(kMethodName);
      log('Started with FLAVOR $flavor');
      _setupEnvironment(flavor);
      fn(true);
    } catch (e) {
      log("Failed: '${e.message}'");
      log('Failed to Load FLAVOR');
      fn(false);
    }
  }

  static _setupEnvironment(String flavorName) async {
    String baseUrl;
    Environment flavor;
    if (flavorName == 'develop') {
      baseUrl = 'http://baseurl.develop';
      flavor = Environment.develop;
    } else if (flavorName == 'production') {
      baseUrl = 'http://baseurl.production';
      flavor = Environment.production;
    }
    _instance = AppConfig(flavor: flavor, apiBaseUrl: baseUrl);
  }
}

import 'package:flutter/material.dart';



class Routes {
  static const String home = '/home';
  static const String currencyHistory = '/currency/history';

  static Map<String, WidgetBuilder> get routes {
    return {
      // home: (context) => const HomePage(),
      // currencyHistory: (context) => const CurrencyHistoryPage(),
    };
  }
}

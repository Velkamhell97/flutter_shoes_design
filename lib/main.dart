import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/providers/shoe_provider.dart';
import 'src/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// Se usa provider para no tener que pasar tanto a los hijos un notifier
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShoeProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w700
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black,
              size: 30
            ),
          )
        ),
        home: const ShoesAppHome()
      ),
    );
  }
}
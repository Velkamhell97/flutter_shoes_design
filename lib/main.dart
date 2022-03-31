import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'src/models/shoe_notifier.dart';
import 'src/pages/pages.dart';

void main() {
  runApp(const MyApp());

  timeDilation = 1;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //-Se usa provider para no tener que pasar tanto a los hijos un notifier
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShoeNotifier(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
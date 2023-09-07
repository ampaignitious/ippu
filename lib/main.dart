import 'package:flutter/material.dart';
import 'package:ippu/Widgets/SplashScreenWidgets/FirstSplashScreen.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

import 'providers/CpdProvider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CpdsProvider()), // Add this line
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstSplashScreen(),
      ),
    );
  }
}


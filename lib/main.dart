import 'package:flutter/material.dart';
import 'package:ippu/Screens/EducationBackgroundScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/WorkExperience.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:ippu/Widgets/SplashScreenWidgets/FirstSplashScreen.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstLaunch = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setValue().then((isFirstLaunch) {
      setState(() {
        this.isFirstLaunch = isFirstLaunch;
        isLoading = false; // Set loading to false once the operation is complete
      });
    });
  }

  Future<bool> setValue() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    if (launchCount == 0) {
      print("first launch");
      // If it's the first launch, return true.
      return true;
    } else {
      print("Not first launch");
      // If it's not the first launch, return false.
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isLoading
            ? const Scaffold(
                backgroundColor: Colors.white, // Set the background color to white
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue, // Set the color of the spinner
                    ),
                  ),
                ),
              )
            : isFirstLaunch
                ? const FirstSplashScreen()
                : LoginScreen(),
        routes: {
          '/myevents': (context) => const EventsScreen(),
          '/educationbackground': (context) =>
              const EducationBackgroundScreen(),
          '/workexperience': (context) => const WorkExperience(),
        },
      ),
    );
  }
}

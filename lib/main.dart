import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ippu/Providers/ProfilePicProvider.dart';
import 'package:ippu/Screens/DefaultScreen.dart';
import 'package:ippu/Screens/EducationBackgroundScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/WorkExperience.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:ippu/Widgets/SplashScreenWidgets/FirstSplashScreen.dart';
import 'package:ippu/firebase_options.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:ippu/services/FirebaseApi.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);  
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
      FirebaseApi().initLocalNotifications();
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
        ChangeNotifierProvider(create: (context)=>ProfilePicProvider())
      ],
      child: OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'IPPU Membership APP',
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
            '/homescreen': (context) => const DefaultScreen(),
          },
        ),
      ),
    );
  }
}
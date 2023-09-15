import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/Screens/ProfileScreen.dart';
import 'package:ippu/Screens/SettingsScreen.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/FirstDisplaySection.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
            drawer:Drawer(
        width: size.width*0.8,
        child: DrawerWidget(),
      ),
      appBar: AppBar(
              // leading: Icon(Icons.menu),
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SettingsScreen();
              }));
            },
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ProfileScreen();
                }));
              },
              child: Padding(
                padding: EdgeInsets.only(right: size.width*0.06),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/image9.png'),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          FirstDisplaySection(),
         ],
      ),
    );
  }
  void showBottomNotification(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
  // 
}
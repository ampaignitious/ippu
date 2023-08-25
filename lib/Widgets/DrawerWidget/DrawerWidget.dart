import 'package:flutter/material.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';



class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                currentAccountPicture: CircleAvatar(backgroundImage: AssetImage('assets/image4.png'),),
                accountName: Text("ampaignitious"), accountEmail: Text("ignitiousampa@gmail.com")),
              Card(
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.cast_for_education),
                  title: Text("Education Background"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.message_rounded),
                  title: Text("Chat"),
                ),
              ),
               Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_on),
                  title: Text("Communications"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.work_history),
                  title: Text("Work Experience"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.event),
                  title: Text("Events"),
                ),
              ),
                          Card(
                child: ListTile(
                  leading: Icon(Icons.pie_chart),
                  title: Text("CPD"),
                ),
              ),
                          Card(
                child: ListTile(
                  leading: Icon(Icons.link),
                  title: Text("Jobs"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.album_outlined),
                  title: Text("Who We Are"),
                ),
              ),
               Card(
                child: ListTile(
                  leading: Icon(Icons.admin_panel_settings_rounded),
                  title: Text("Our Core Values"),
                ),
              ),
               InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return LoginScreen();
                  }));
                },
                 child: Card(
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app_rounded),
                    title: Text("Logout"),
                  ),
                           ),
               ),
            ],
          ),
    );
  }
}
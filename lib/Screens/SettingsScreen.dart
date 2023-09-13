import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        backgroundColor:Color.fromARGB(255, 42, 129, 201) ,
        title:Text("Setting", style:GoogleFonts.lato())
      ),
      body: Center(
        child: Text("App Settings to be added"),
      ),
    );
  }
}
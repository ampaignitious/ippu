import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/AttendedSingleCpdDisplay.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/attendedCpdListBuilder.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class AttendedCpdsScreen extends StatefulWidget {
  const AttendedCpdsScreen({super.key});

  @override
  State<AttendedCpdsScreen> createState() => _AttendedCpdsScreenState();
}

class _AttendedCpdsScreenState extends State<AttendedCpdsScreen> {
  

@override

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
 
          Divider(),
          Container(
            height: size.height*0.90,
            width: double.maxFinite,
 
            child: attendedCpdListBuilder(),
            ),
        ],
      ),
    );
  }
}


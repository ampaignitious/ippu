import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Working Experience", style: GoogleFonts.lato(),),
      ) ,
    );
  }
}
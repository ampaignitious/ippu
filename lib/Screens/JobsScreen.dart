import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        elevation: 0,
        title: Text("Jobs",style:GoogleFonts.lato()),
      ),
      body: Center(
        child: Text("No jobs"),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EducationBackgroundWidgets/ContainerDisplayingEducationDetails.dart';


class EducationBackgroundScreen extends StatefulWidget {
  const EducationBackgroundScreen({super.key});

  @override
  State<EducationBackgroundScreen> createState() => _EducationBackgroundScreenState();
}

class _EducationBackgroundScreenState extends State<EducationBackgroundScreen> {
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        elevation: 0,
        title: Text("Education Background",style:GoogleFonts.lato()),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        onPressed: _showAddEducationDialog,
        tooltip: 'Add Education',
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height*0.009,
          ),
          Container(
            height: size.height*0.85,
            width: double.maxFinite,
            child: ContainerDisplayingEducationDetails()),
        ],
      ),
    );
  }



// 

  void _showAddEducationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Background'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Institute Name'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Field of Study'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Points Scored'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Start Date'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'End Date'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save education details and close dialog
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
// 

}
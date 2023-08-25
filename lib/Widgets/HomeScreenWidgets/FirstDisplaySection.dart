import 'package:flutter/material.dart';

class FirstDisplaySection extends StatefulWidget {
  const FirstDisplaySection({super.key});

  @override
  State<FirstDisplaySection> createState() => _FirstDisplaySectionState();
}

class _FirstDisplaySectionState extends State<FirstDisplaySection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Stack(
      children: [

        Container(
                height: size.height*0.30,
                width: size.width*1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(210, 63, 131, 187),
                ),
                child: Column(
                  children: [
                    Text("Welcome to IPPU mobile application", style: TextStyle(color: Colors.white, fontSize: size.height*0.016),),
                    SizedBox(height: size.height*0.026,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // the home screen section displays ( available events)
                    Container(
                    height: size.height*0.16,
                    width: size.width*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // the row displaying icon and text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // container containing the event icon
                            Container(
                    height: size.height*0.075,
                    width: size.width*0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 50, 155, 132),
                    ),
                    child: Icon(Icons.event, color: Colors.white,
                    size: size.height*0.022,
                    ),
                    ),
                    Text("Available Events")
                          ],
                        ),
                        // end of the row section
                        Divider(
                          thickness: 2,
                          color: Color.fromARGB(210, 63, 131, 187),
                        ),
                    Center(child: Text("5,235", style: TextStyle(fontSize: size.height*0.0342, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 50, 155, 132), letterSpacing: 1),))
                      ],
                    ),
                    ),
                    // attend CPD
                                   Container(
                    height: size.height*0.16,
                    width: size.width*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // the row displaying icon and text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // container containing the event icon
                            Container(
                    height: size.height*0.075,
                    width: size.width*0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 50, 155, 132),
                    ),
                    child: Icon(
                      Icons.workspace_premium, color: Colors.white,
                      size: size.height*0.024,
                      ),
                    ),
                    Text("Attended CPDS")
                          ],
                        ),
                        // end of the row section
                        Divider(
                          thickness: 2,
                          color: Color.fromARGB(210, 63, 131, 187),
                        ),
                    Center(child: Text("125", style: TextStyle(fontSize: size.height*0.0342, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 50, 155, 132),letterSpacing: 1),))
                      ],
                    ),
                    ),
                      ],
                    ),
                  ],
                ),
              ),
                      // 
        Container(
          margin: EdgeInsets.only(top: size.height*0.24, left: size.width*0.032 ),
                    height: size.height*0.56,
                    width: size.width*0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    )),
        // 
      ],
    )
        ;
  }
}
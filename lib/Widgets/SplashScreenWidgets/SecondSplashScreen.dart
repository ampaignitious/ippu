import 'package:flutter/material.dart';
import 'package:ippu/Util/TextWords.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:ippu/Widgets/SplashScreenWidgets/ThirdSplashScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({super.key});

  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 160), // Adjust the duration as needed
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginScreen();
                    }));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: size.width*0.05),
                    child: Text("skip", style: TextStyle(fontSize: size.height*0.025, color: Color.fromARGB(255, 42, 129, 201), fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height*0.088,
            ),
            Container(
  height: size.height * 0.35,
  width: double.maxFinite,
  child: RotationTransition(
    turns: _controller,
    child: DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/image6.png")),
      ),
    ),
  ),
),
              SizedBox(
              height: size.height*0.048,
            ),
            Text("EVENTS & CPD Trainings", style: GoogleFonts.lato(
            fontSize: size.height*0.0415, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 42, 129, 201)
            ),),
            
            SizedBox(
              height: size.height*0.015,
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width*0.05, left: size.width*0.06),
              child: Text("${eventsAndTraining}", style: TextStyle(fontSize: size.height
              *0.016),),
            ),
            SizedBox(
              height: size.height*0.055,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                },
                  child: Container(
                    margin: EdgeInsets.only(left: size.width*0.04),
                    height: size.height*0.08,
                    width: size.width*0.16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue)
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.blue, size: size.height*0.04,),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: size.width*0.048),
                      height: size.height*0.052,
                      width: size.width*0.062,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width*0.04),
                      height: size.height*0.052,
                      width: size.width*0.062,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 42, 129, 201),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width*0.04),
                      height: size.height*0.052,
                      width: size.width*0.062,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                       color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ThirdSplashScreen();
                }));},
                  child: Container(
                    margin: EdgeInsets.only(right: size.width*0.04),
                    height: size.height*0.08,
                    width: size.width*0.16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 42, 129, 201),
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white, size: size.height*0.04,),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      );
  }
}
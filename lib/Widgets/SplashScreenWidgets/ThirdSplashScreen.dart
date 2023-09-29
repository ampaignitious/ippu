import 'package:flutter/material.dart';
import 'package:ippu/Util/TextWords.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
 
class ThirdSplashScreen extends StatefulWidget {
  const ThirdSplashScreen({super.key});

  @override
  State<ThirdSplashScreen> createState() => _ThirdSplashScreenState();
}

class _ThirdSplashScreenState extends State<ThirdSplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              height: size.height*0.35,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/image3.png")),
              ),
            ),
              SizedBox(
              height: size.height*0.048,
            ),
            Text("Effective communication", style: TextStyle(
              fontSize: size.width * 0.082, 
              fontWeight: FontWeight.bold,color: Color.fromARGB(255, 42, 129, 201)),),
            SizedBox(
              height: size.height*0.015,
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width*0.05, left: size.width*0.06),
              child: Text(" ${effectiveCommunication}", style: TextStyle(fontSize: size.height
              *0.018),),
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
                      // color: Colors.grey,
                      border: Border.all(color: Color.fromARGB(255, 42, 129, 201)),
                      
                    ),
                    child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 42, 129, 201), size: size.height*0.04,),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: size.width*0.048),
                        height: size.height*0.052,
                        width: size.width*0.062,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
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
                    Container(
                      margin: EdgeInsets.only(left: size.width*0.04),
                      height: size.height*0.052,
                      width: size.width*0.062,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                       color: Color.fromARGB(255, 42, 129, 201),
                      ),
                    ),
                  ],
                ),
                  InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
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